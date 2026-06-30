import pandas as pd
from sklearn.metrics import roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder


def test_baseline_auc():
    df = pd.read_csv("e:/BANK TRANSACTION ANALYTICS/Dataset/bank_txn_20260625_0918_01.csv")
    features = ["Amount", "Transaction_Type", "Merchant_Category", "Transaction_Channel", "Risk_Score", "Credit_Score"]
    x = df[features]
    y = df["Fraud_Label"]
    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42, stratify=y)
    cat_cols = [c for c in features if x[c].dtype == "object"]
    num_cols = [c for c in features if c not in cat_cols]
    model = Pipeline([
        ("prep", ColumnTransformer([("cat", OneHotEncoder(handle_unknown="ignore"), cat_cols), ("num", "passthrough", num_cols)])),
        ("clf", RandomForestClassifier(n_estimators=120, random_state=42)),
    ])
    model.fit(x_train, y_train)
    auc = roc_auc_score(y_test, model.predict_proba(x_test)[:, 1])
    assert auc >= 0.70
