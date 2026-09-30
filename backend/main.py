
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

app = FastAPI(title="Finance Tracker API")

class Transaction(BaseModel):
    id: int
    category: str
    amount: float
    type: str  # income , expense

transactions_db: List[Transaction] = []

@app.get("/")
def read_root():
    return {"service": "Finance Tracker API", "status": "running"}

@app.post("/transactions/", response_model=Transaction)
def create_transaction(transaction: Transaction):
    transactions_db.append(transaction)
    return transaction

@app.get("/transactions/", response_model=List[Transaction])
def get_transactions():
    return transactions_db