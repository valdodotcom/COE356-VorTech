import sqlite3
DATABASE_NAME = "Basic.db"


def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn


def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS Customer(
           CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
           CustomerName TEXT NOT NULL,
           CustomerEmail TEXT NOT NULL,
           CustomerPhoneNo INT,
           CustomerPassword TEXT NOT NULL,
           CustomerAddress TEXT NOT NULL,
            
        )
        """
    ]

    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)
