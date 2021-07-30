import sqlite3
DATABASE_NAME = "instashop_database.db"


def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn


def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS admin(
            AdminID INTEGER PRIMARY KEY AUTOINCREMENT,
            AdminName TEXT NOT NULL,
            AdminEmail TEXT NOT NULL,
            AdminPhoneNo INT,
            AdminPassword TEXT NOT NULL,
            AdminAddress TEXT NOT NULL,
            Product TEXT,
            ProductCategory TEXT,
            ProductPicture TEXT,
            ProductPrice REAL
        )
        """
    ]

    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)
