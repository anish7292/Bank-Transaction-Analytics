import joblib
import pandas as pd


def score(input_csv: str, model_path: str, output_csv: str) -> None:
    df = pd.read_csv(input_csv)
    model = joblib.load(model_path)
    features = ["Amount", "Transaction_Type", "Merchant_Category", "Transaction_Channel", "Risk_Score", "Credit_Score"]
    df["Fraud_Probability"] = model.predict_proba(df[features])[:, 1]
    df.to_csv(output_csv, index=False)


if __name__ == "__main__":
    score(
        "e:/BANK TRANSACTION ANALYTICS/Dataset/bank_txn_20260625_0918_02.csv",
        "e:/BANK TRANSACTION ANALYTICS/Python/models/fraud_model.joblib",
        "e:/BANK TRANSACTION ANALYTICS/Dataset/scored_transactions.csv",
    )
