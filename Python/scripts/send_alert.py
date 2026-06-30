import json
import urllib.request


def send_webhook_alert(webhook_url: str, title: str, message: str) -> None:
    payload = {"title": title, "message": message}
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(
        webhook_url,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    with urllib.request.urlopen(req, timeout=15) as response:
        print("Alert sent:", response.status)


if __name__ == "__main__":
    # Replace with real webhook in deployment
    url = "https://example-webhook.local/notify"
    send_webhook_alert(url, "Bank Pipeline Failure", "Pipeline pl_master_bank_ingestion failed.")
