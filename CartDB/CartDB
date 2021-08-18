import sqlite3
DATABASE_NAME = "Cart.db"


def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn


def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS Cart(
           CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
           VendorID INTEGER FOREIGN KEY,
           ProductForSale TEXT NOT NULL,
           ProductCategory TEXT NOT NULL,
           ProductImage TEXT NOT NULL,
           Price INT ,
           
            
        )
        """
    ]

    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)
