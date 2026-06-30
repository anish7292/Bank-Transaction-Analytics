from pathlib import Path
import json
from datetime import UTC, datetime


def register(model_path: str, metrics: dict, registry_file: str) -> None:
    payload = {
        "model_path": model_path,
        "registered_utc": datetime.now(UTC).isoformat(),
        "metrics": metrics,
    }
    Path(registry_file).parent.mkdir(parents=True, exist_ok=True)
    with open(registry_file, "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2)


if __name__ == "__main__":
    register(
        "e:/BANK TRANSACTION ANALYTICS/Python/models/fraud_model.joblib",
        {"auc": 0.91, "precision": 0.88, "recall": 0.73},
        "e:/BANK TRANSACTION ANALYTICS/Python/models/model_registry.json",
    )
