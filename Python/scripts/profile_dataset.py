import csv
from collections import Counter
from pathlib import Path


ROOT = Path("e:/BANK TRANSACTION ANALYTICS")
DATASET_DIR = ROOT / "Dataset"
OUT = DATASET_DIR / "quality_profile.md"


def main():
    files = sorted(DATASET_DIR.glob("bank_txn_*.csv"))
    total_rows = 0
    dup_check = set()
    duplicates = 0
    fraud_count = 0
    channel_counter = Counter()
    type_counter = Counter()

    for file in files:
        with file.open("r", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                total_rows += 1
                txn_id = row["Transaction_ID"]
                if txn_id in dup_check:
                    duplicates += 1
                else:
                    dup_check.add(txn_id)
                fraud_count += int(row["Fraud_Label"])
                channel_counter[row["Transaction_Channel"]] += 1
                type_counter[row["Transaction_Type"]] += 1

    with OUT.open("w", encoding="utf-8") as f:
        f.write("# Quality Profile\n\n")
        f.write(f"- Total rows: `{total_rows}`\n")
        f.write(f"- Duplicate Transaction_ID rows: `{duplicates}`\n")
        f.write(f"- Fraud rows: `{fraud_count}`\n")
        f.write(f"- Fraud %: `{(fraud_count / total_rows * 100):.2f}`\n\n")
        f.write("## Transaction Channels\n")
        for k, v in channel_counter.most_common():
            f.write(f"- {k}: {v}\n")
        f.write("\n## Transaction Types\n")
        for k, v in type_counter.most_common():
            f.write(f"- {k}: {v}\n")

    print(f"Written: {OUT}")


if __name__ == "__main__":
    main()
