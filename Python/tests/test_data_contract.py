import pandas as pd


REQUIRED_COLUMNS = {
    "Transaction_ID", "Customer_ID", "Account_ID", "Transaction_Date", "Amount", "Fraud_Label", "Risk_Score"
}


def test_contract_columns():
    df = pd.read_csv("e:/BANK TRANSACTION ANALYTICS/Dataset/bank_txn_20260625_0918_01.csv", nrows=10)
    assert REQUIRED_COLUMNS.issubset(set(df.columns))
