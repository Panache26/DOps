from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["status"] == "running"

def test_create_transaction():
    payload = {
        "id": 1,
        "category": "Groceries",
        "amount": 250.50,
        "type": "expense"
    }
    response = client.post("/transactions/", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["amount"] == 250.50
    assert data["category"] == "Groceries"
    