CREATE TABLE dw.DimDate (
    DateKey INT NOT NULL PRIMARY KEY,
    [Date] DATE NOT NULL,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    [Month] INT NOT NULL,
    MonthName NVARCHAR(20) NOT NULL,
    DayOfMonth INT NOT NULL
);

CREATE TABLE dw.DimCustomer (
    CustomerKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Customer_ID NVARCHAR(50) NOT NULL UNIQUE,
    Customer_Age INT NULL,
    Gender NVARCHAR(20) NULL,
    Occupation NVARCHAR(100) NULL,
    Income_Level NVARCHAR(50) NULL,
    Credit_Score INT NULL,
    Customer_Segment NVARCHAR(50) NULL
);

CREATE TABLE dw.DimAccount (
    AccountKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Account_ID NVARCHAR(50) NOT NULL UNIQUE,
    Account_Type NVARCHAR(50) NULL,
    IFSC_Code NVARCHAR(20) NULL
);

CREATE TABLE dw.DimMerchant (
    MerchantKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Merchant_Name NVARCHAR(200) NOT NULL,
    Merchant_Category NVARCHAR(100) NULL
);

CREATE TABLE dw.DimLocation (
    LocationKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Merchant_City NVARCHAR(100) NULL,
    Merchant_State NVARCHAR(100) NULL,
    Merchant_Country NVARCHAR(100) NULL,
    Latitude DECIMAL(10,6) NULL,
    Longitude DECIMAL(10,6) NULL
);

CREATE TABLE dw.DimBranch (
    BranchKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Branch_ID NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dw.DimPaymentMethod (
    PaymentMethodKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Payment_Method NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dw.DimDevice (
    DeviceKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Device_Type NVARCHAR(50) NULL,
    Operating_System NVARCHAR(50) NULL
);

CREATE TABLE dw.DimCard (
    CardKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Card_Type NVARCHAR(50) NULL,
    Card_Network NVARCHAR(50) NULL
);

CREATE TABLE dw.DimChannel (
    ChannelKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Transaction_Channel NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dw.DimCurrency (
    CurrencyKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CurrencyCode NVARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE dw.DimRisk (
    RiskKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    RiskBand NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dw.DimLoan (
    LoanKey INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Loan_Status NVARCHAR(50) NOT NULL UNIQUE
);
