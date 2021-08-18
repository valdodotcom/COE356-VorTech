from Cartdb1 import get_db

"""  INSERT, DELETE, GET"""


def insert(CustomerID, VendorID, ProductForSale, ProductCategory, ProductImage,Price):
    Cartdb1 = get_db()
    cursor = Cartdb1.cursor()
    statement = "INSERT INTO Customer(CustomerID, VendorID, ProductForSale, ProductCategory, ProductImage,Price) VALUES (?,?,?,?,?,?)"
    cursor.execute(statement, [CustomerID, VendorID, ProductForSale,
                   ProductCategory, ProductImage,Price])
    Cartdb1.commit()
    return {"status": 201, "message": "Record inserted into database"}




def get_all_products():
    Cartdb1 = get_db()
    cursor = Cartdb1.cursor()
    query = "SELECT * FROM Cart"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}


def delete_product(CustomerID):
    Cartdb1 = get_db()
    cursor = Cartdb1.cursor()
    statement = "DELETE FROM Cart WHERE CustomerID = ?"
    cursor.execute(statement, [CustomerID])
    Cartdb1.commit()
    return {"status": 201, "message": "item successfully deleted"}


def delete_account():
    pass
