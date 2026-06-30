CREATE OR ALTER PROCEDURE dw.usp_transform_and_load_dw
    @BatchId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        /* ===========================
   LOAD DIM CUSTOMER
=========================== */

INSERT INTO dw.DimCustomer
(
    Customer_ID,
    Customer_Age,
    Gender,
    Occupation,
    Income_Level,
    Credit_Score,
    Customer_Segment
)
SELECT
    s.Customer_ID,
    s.Customer_Age,
    s.Gender,
    s.Occupation,
    s.Income_Level,
    s.Credit_Score,
    s.Customer_Segment
FROM
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY Customer_ID
               ORDER BY Transaction_Date DESC,
                        Transaction_Time DESC
           ) AS rn
    FROM stg.Transactions_Raw
    WHERE BatchId=@BatchId
)s
WHERE s.rn=1
AND NOT EXISTS
(
    SELECT 1
    FROM dw.DimCustomer d
    WHERE d.Customer_ID=s.Customer_ID
);

        MERGE dw.DimAccount AS tgt
        USING (
            SELECT
    Account_ID,
    Account_Type,
    IFSC_Code
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Account_ID
               ORDER BY Transaction_Date DESC, Transaction_Time DESC
           ) rn
    FROM stg.Transactions_Raw
    WHERE BatchId = @BatchId
) t
WHERE rn = 1
           
        ) AS src
        ON tgt.Account_ID = src.Account_ID
        WHEN MATCHED THEN UPDATE SET tgt.Account_Type = src.Account_Type, tgt.IFSC_Code = src.IFSC_Code
        WHEN NOT MATCHED THEN INSERT (Account_ID, Account_Type, IFSC_Code) VALUES (src.Account_ID, src.Account_Type, src.IFSC_Code);

        INSERT INTO dw.DimBranch (Branch_ID)
        SELECT DISTINCT r.Branch_ID
        FROM stg.Transactions_Raw r
        WHERE r.BatchId = @BatchId
          AND NOT EXISTS (SELECT 1 FROM dw.DimBranch d WHERE d.Branch_ID = r.Branch_ID);

        INSERT INTO dw.DimChannel (Transaction_Channel)
        SELECT DISTINCT r.Transaction_Channel
        FROM stg.Transactions_Raw r
        WHERE r.BatchId = @BatchId
          AND NOT EXISTS (SELECT 1 FROM dw.DimChannel d WHERE d.Transaction_Channel = r.Transaction_Channel);

        INSERT INTO dw.DimRisk (RiskBand)
        SELECT DISTINCT CASE
            WHEN r.Risk_Score >= 80 THEN 'HIGH'
            WHEN r.Risk_Score >= 50 THEN 'MEDIUM'
            ELSE 'LOW' END
        FROM stg.Transactions_Raw r
        WHERE r.BatchId = @BatchId
          AND NOT EXISTS (
              SELECT 1 FROM dw.DimRisk d
              WHERE d.RiskBand = CASE
                  WHEN r.Risk_Score >= 80 THEN 'HIGH'
                  WHEN r.Risk_Score >= 50 THEN 'MEDIUM'
                  ELSE 'LOW' END
          );

        INSERT INTO dw.Fact_Transactions
        (Transaction_ID, DateKey, CustomerKey, AccountKey, BranchKey, ChannelKey, RiskKey,
         AmountINR, Balance_Before, Balance_After, Fraud_Label, Risk_Score)
        SELECT
            r.Transaction_ID,
            CONVERT(INT, FORMAT(r.Transaction_Date, 'yyyyMMdd')) AS DateKey,
            c.CustomerKey,
            a.AccountKey,
            b.BranchKey,
            ch.ChannelKey,
            rk.RiskKey,
            r.Amount,
            r.Balance_Before,
            r.Balance_After,
            r.Fraud_Label,
            r.Risk_Score
        FROM stg.Transactions_Raw r
        INNER JOIN dw.DimCustomer c ON c.Customer_ID = r.Customer_ID
        INNER JOIN dw.DimAccount a ON a.Account_ID = r.Account_ID
        LEFT JOIN dw.DimBranch b ON b.Branch_ID = r.Branch_ID
        LEFT JOIN dw.DimChannel ch ON ch.Transaction_Channel = r.Transaction_Channel
        LEFT JOIN dw.DimRisk rk ON rk.RiskBand = CASE WHEN r.Risk_Score >= 80 THEN 'HIGH' WHEN r.Risk_Score >= 50 THEN 'MEDIUM' ELSE 'LOW' END
        WHERE r.BatchId = @BatchId
          AND NOT EXISTS (
              SELECT 1
              FROM dw.Fact_Transactions f
              WHERE f.Transaction_ID = r.Transaction_ID
          );

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH;
END;
GO
