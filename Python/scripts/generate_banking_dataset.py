import csv
import random
from datetime import UTC, datetime, timedelta
from pathlib import Path


ROOT = Path("e:/BANK TRANSACTION ANALYTICS")
DATASET_DIR = ROOT / "Dataset"
DATASET_DIR.mkdir(parents=True, exist_ok=True)

TOTAL_ROWS = 500000
FILES = 5
ROWS_PER_FILE = TOTAL_ROWS // FILES

TRANSACTION_TYPES = ["DEPOSIT", "WITHDRAWAL", "TRANSFER", "POS", "UPI", "BILLPAY", "EMI"]
MERCHANT_CATEGORIES = ["GROCERY", "FUEL", "TRAVEL", "RETAIL", "HEALTHCARE", "DINING", "UTILITIES", "EDUCATION"]
CITIES = [("Mumbai", "MH"), ("Delhi", "DL"), ("Bengaluru", "KA"), ("Hyderabad", "TS"), ("Chennai", "TN"), ("Pune", "MH")]
COUNTRY = "India"
PAYMENT_METHODS = ["Cash", "Card", "UPI", "NetBanking", "Wallet"]
CURRENCIES = ["INR", "USD", "EUR"]
DEVICE_TYPES = ["Mobile", "Desktop", "ATM", "POS"]
OPERATING_SYSTEMS = ["Android", "iOS", "Windows", "Linux"]
CHANNELS = ["Branch", "ATM", "Internet Banking", "Mobile Banking", "UPI"]
GENDERS = ["Male", "Female", "Other"]
OCCUPATIONS = ["Salaried", "Business", "Student", "Retired", "Freelancer", "Self-Employed"]
INCOME_LEVELS = ["Low", "Middle", "Upper-Middle", "High"]
ACCOUNT_TYPES = ["Savings", "Current", "Salary", "NRI"]
CARD_TYPES = ["Debit", "Credit", "Prepaid"]
CARD_NETWORKS = ["Visa", "Mastercard", "RuPay", "Amex"]
LOAN_STATUS = ["No Loan", "Active", "Closed", "Delinquent"]
CUSTOMER_SEGMENT = ["Mass", "Affluent", "HNI", "SME"]


HEADERS = [
    "Transaction_ID", "Customer_ID", "Account_ID", "Transaction_Date", "Transaction_Time", "Amount",
    "Transaction_Type", "Merchant_Name", "Merchant_Category", "Merchant_City", "Merchant_State",
    "Merchant_Country", "Payment_Method", "Currency", "Device_Type", "Operating_System",
    "Transaction_Channel", "ATM_ID", "Branch_ID", "IFSC_Code", "Customer_Age", "Gender",
    "Occupation", "Income_Level", "Credit_Score", "Account_Type", "Balance_Before",
    "Balance_After", "Latitude", "Longitude", "IP_Address", "Login_Time", "Logout_Time",
    "Fraud_Label", "Risk_Score", "Card_Type", "Card_Network", "Loan_Status", "Customer_Segment"
]


def random_ifsc():
    bank = random.choice(["HDFC", "ICIC", "SBIN", "AXIS", "PUNB"])
    branch = random.randint(100000, 999999)
    return f"{bank}0{branch}"


def random_ip():
    return ".".join(str(random.randint(1, 254)) for _ in range(4))


def merchant_name(category):
    return f"{category}_MERCHANT_{random.randint(1, 250)}"


def risk_from_features(amount, credit_score, is_fraud):
    base = min(95, max(5, int((amount / 1000) + (700 - credit_score) * 0.15)))
    if is_fraud:
        base = min(99, base + random.randint(20, 40))
    return base


def generate_row(i, start_date):
    customer_id = f"CUST{random.randint(100000, 999999)}"
    account_id = f"ACC{random.randint(1000000, 9999999)}"
    dt = start_date + timedelta(minutes=random.randint(0, 525600))
    txn_type = random.choice(TRANSACTION_TYPES)
    amount = round(random.triangular(50, 200000, 5000), 2)
    category = random.choice(MERCHANT_CATEGORIES)
    city, state = random.choice(CITIES)
    payment_method = random.choice(PAYMENT_METHODS)
    currency = random.choices(CURRENCIES, weights=[92, 6, 2], k=1)[0]
    device = random.choice(DEVICE_TYPES)
    os = random.choice(OPERATING_SYSTEMS)
    channel = random.choice(CHANNELS)
    atm_id = f"ATM{random.randint(1000, 9999)}" if channel == "ATM" else ""
    branch_id = f"BR{random.randint(101, 999)}"
    age = random.randint(18, 78)
    gender = random.choice(GENDERS)
    occupation = random.choice(OCCUPATIONS)
    income_level = random.choice(INCOME_LEVELS)
    credit_score = random.randint(300, 900)
    account_type = random.choice(ACCOUNT_TYPES)
    balance_before = round(random.uniform(1000, 3000000), 2)
    signed_amt = amount if txn_type in ["DEPOSIT"] else -amount
    balance_after = round(balance_before + signed_amt, 2)
    lat = round(random.uniform(8.0, 37.0), 6)
    lon = round(random.uniform(68.0, 97.0), 6)
    login_time = dt - timedelta(minutes=random.randint(1, 60))
    logout_time = dt + timedelta(minutes=random.randint(1, 30))
    fraud = 1 if random.random() < 0.018 else 0
    risk_score = risk_from_features(amount, credit_score, fraud)
    card_type = random.choice(CARD_TYPES)
    card_network = random.choice(CARD_NETWORKS)
    loan_status = random.choice(LOAN_STATUS)
    segment = random.choice(CUSTOMER_SEGMENT)

    return [
        f"TXN{i:09d}",
        customer_id,
        account_id,
        dt.strftime("%Y-%m-%d"),
        dt.strftime("%H:%M:%S"),
        amount,
        txn_type,
        merchant_name(category),
        category,
        city,
        state,
        COUNTRY,
        payment_method,
        currency,
        device,
        os,
        channel,
        atm_id,
        branch_id,
        random_ifsc(),
        age,
        gender,
        occupation,
        income_level,
        credit_score,
        account_type,
        balance_before,
        balance_after,
        lat,
        lon,
        random_ip(),
        login_time.strftime("%Y-%m-%d %H:%M:%S"),
        logout_time.strftime("%Y-%m-%d %H:%M:%S"),
        fraud,
        risk_score,
        card_type,
        card_network,
        loan_status,
        segment,
    ]


def write_files():
    start_date = datetime(2024, 1, 1, 0, 0, 0)
    serial = 1
    for file_no in range(1, FILES + 1):
        ts = datetime.now(UTC).strftime("%Y%m%d_%H%M")
        file_path = DATASET_DIR / f"bank_txn_{ts}_{file_no:02d}.csv"
        with file_path.open("w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            writer.writerow(HEADERS)
            for _ in range(ROWS_PER_FILE):
                writer.writerow(generate_row(serial, start_date))
                serial += 1
        print(f"Written: {file_path}")


def write_data_dictionary():
    path = DATASET_DIR / "data_dictionary.md"
    with path.open("w", encoding="utf-8") as f:
        f.write("# Banking Dataset Data Dictionary\n\n")
        for col in HEADERS:
            f.write(f"- `{col}`: business attribute used for banking analytics.\n")
    print(f"Written: {path}")


if __name__ == "__main__":
    random.seed(42)
    write_files()
    write_data_dictionary()
    print("Dataset generation completed.")
