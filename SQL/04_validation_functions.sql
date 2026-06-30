CREATE OR ALTER FUNCTION stg.ufn_is_valid_ifsc (@ifsc NVARCHAR(20))
RETURNS BIT
AS
BEGIN
    DECLARE @is_valid BIT = 0;
    IF @ifsc LIKE '[A-Z][A-Z][A-Z][A-Z]0[0-9][0-9][0-9][0-9][0-9][0-9]'
        SET @is_valid = 1;
    RETURN @is_valid;
END;
GO

CREATE OR ALTER FUNCTION stg.ufn_normalized_currency_amount
(
    @amount DECIMAL(18,2),
    @currency NVARCHAR(10)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @converted DECIMAL(18,2);
    SET @converted = CASE @currency
        WHEN 'INR' THEN @amount
        WHEN 'USD' THEN @amount * 83.00
        WHEN 'EUR' THEN @amount * 90.00
        ELSE @amount
    END;
    RETURN @converted;
END;
GO
