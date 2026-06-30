from pathlib import Path
import joblib
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder
from sklearn.ensemble import RandomForestClassifier


def train(input_csv: str, output_model: str) -> None:
    df = pd.read_csv(input_csv)
    y = df["Fraud_Label"]
    features = ["Amount", "Transaction_Type", "Merchant_Category", "Transaction_Channel", "Risk_Score", "Credit_Score"]
    x = df[features]

    cat_cols = [c for c in features if x[c].dtype == "object"]
    num_cols = [c for c in features if c not in cat_cols]

    prep = ColumnTransformer([
        ("cat", OneHotEncoder(handle_unknown="ignore"), cat_cols),
        ("num", "passthrough", num_cols),
    ])
    model = Pipeline([("prep", prep), ("clf", RandomForestClassifier(n_estimators=200, random_state=42))])
    model.fit(x, y)
    Path(output_model).parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(model, output_model)


if __name__ == "__main__":
    train("e:/BANK TRANSACTION ANALYTICS/Dataset/bank_txn_20260625_0918_01.csv",
          "e:/BANK TRANSACTION ANALYTICS/Python/models/fraud_model.joblib")
