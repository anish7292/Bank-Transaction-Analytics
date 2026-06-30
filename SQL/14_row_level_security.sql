CREATE SCHEMA sec;
GO

CREATE TABLE sec.UserBranchAccess (
    UserPrincipalName NVARCHAR(256) NOT NULL,
    Branch_ID NVARCHAR(50) NOT NULL,
    PRIMARY KEY (UserPrincipalName, Branch_ID)
);
GO

CREATE OR ALTER FUNCTION sec.fn_branch_access_predicate (@BranchKey INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS fn_result
    FROM dw.DimBranch b
    INNER JOIN sec.UserBranchAccess uba
        ON uba.Branch_ID = b.Branch_ID
       AND uba.UserPrincipalName = USER_NAME()
    WHERE b.BranchKey = @BranchKey;
GO

CREATE SECURITY POLICY sec.BranchAccessPolicy
ADD FILTER PREDICATE sec.fn_branch_access_predicate(BranchKey)
ON dw.Fact_Transactions
WITH (STATE = ON);
GO
