from customerdb1 import get_db

""" UPDATE, INSERT, DELETE, GET"""


def insert(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress):
    customerdb1 = get_db()
    cursor = customerdb1.cursor()
    statement = "INSERT INTO Customer(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress) VALUES (?,?,?,?,?,?)"
    cursor.execute(statement, [CustomerName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress])
    customerdb1.commit()
    return {"status": 201, "message": "Record inserted into database"}


def update(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, CustomerID):
    customerdb1 = get_db()
    cursor = customerdb1.cursor()
    statement = "UPDATE Customer SET CustomerName=?, CustomerEmail=?, CustomerPhoneNo=?, CustomerPassword=?, CustomerAddress=? WHERE CustomerID=?"
    cursor.execute(statement, [CustomerName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress, CustomerID])
    customerdb1.commit()
    return True


def get_product(CustomerID=None, CustomerName=None):
    customerdb1 = get_db()
    cursor = customerdb1.cursor()
    if CustomerID:
        statement = "SELECT CustomerName, CustomerEmail, CustomerPhoneNo FROM Customer WHERE CustomerID=?"
        cursor.execute(statement, [CustomerID])
    if CustomerName:
        statement = "SELECT CustomerName, CustomerEmail, CustomerPhoneNo FROM Customer WHERE CustomerName=?"
        cursor.execute(statement, [CustomerName])
    return cursor.fetchone()


def get_all_products():
    customerdb1 = get_db()
    cursor = customerdb1.cursor()
    query = "SELECT * FROM Customer"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}


def delete_product(CustomerID):
    customerdb1 = get_db()
    cursor = customerdb1.cursor()
    statement = "DELETE FROM Customer WHERE CustomerID = ?"
    cursor.execute(statement, [CustomerID])
    customerdb1.commit()
    return {"status": 201, "message": "item successfully deleted"}


def delete_account():
    pass
