INSERT INTO dw.DimRisk (RiskBand)
SELECT v.RiskBand
FROM (VALUES ('LOW'), ('MEDIUM'), ('HIGH')) v(RiskBand)
WHERE NOT EXISTS (SELECT 1 FROM dw.DimRisk d WHERE d.RiskBand = v.RiskBand);

INSERT INTO dw.DimCurrency (CurrencyCode)
SELECT v.CurrencyCode
FROM (VALUES ('INR'), ('USD'), ('EUR')) v(CurrencyCode)
WHERE NOT EXISTS (SELECT 1 FROM dw.DimCurrency d WHERE d.CurrencyCode = v.CurrencyCode);

INSERT INTO dw.DimChannel (Transaction_Channel)
SELECT v.ChannelName
FROM (VALUES ('Branch'), ('ATM'), ('Internet Banking'), ('Mobile Banking'), ('UPI')) v(ChannelName)
WHERE NOT EXISTS (SELECT 1 FROM dw.DimChannel d WHERE d.Transaction_Channel = v.ChannelName);
