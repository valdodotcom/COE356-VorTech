from db import get_db

""" UPDATE, INSERT, DELETE, GET"""


def insert(AdminName, AdminEmail, AdminPhoneNo, AdminPassword, AdminAddress, AdminProduct=None, ProductCategory=None, ProductPicture=None, ProductPrice=None):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO admin(AdminName, AdminEmail, AdminPhoneNo, AdminPassword, AdminAddress, AdminProduct, ProductCategory, ProductPicture, ProductPrice) VALUES (?,?,?,?,?,?,?,?,?)"
    cursor.execute(statement, [AdminName, AdminEmail, AdminPhoneNo,
                   AdminPassword, AdminAddress, AdminProduct, ProductCategory, ProductPicture, ProductPrice])
    db.commit()
    return {"status": 201, "message": "Record inserted into database"}


def update(AdminName, AdminEmail, AdminPhoneNo, AdminPassword, AdminAddress, AdminID, Product=None, ProductCategory=None, ProductPicture=None, ProductPrice=None):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE admin SET AdminName=?, AdminEmail=?, AdminPhoneNo=?, AdminPassword=?, AdminAddress=?, Product=?, ProductCategory=?, ProductPicture=?, ProductPrice=? WHERE AdminID=?"
    cursor.execute(statement, [AdminName, AdminEmail, AdminPhoneNo,
                   AdminPassword, AdminAddress, AdminProduct, ProductCategory, ProductPicture, ProductPrice, AdminID])
    db.commit()
    return True


def get_product(AdminID=None, AdminName=None):
    db = get_db()
    cursor = db.cursor()
    if AdminID:
        statement = "SELECT AdminName, AdminEmail, AdminPhoneNo, Product, ProductCategory, ProductPrice FROM admin WHERE AdminID=?"
        cursor.execute(statement, [AdminID])
    if AdminName:
        statement = "SELECT AdminName, AdminEmail, AdminPhoneNo, Product, ProductCategory, ProductPrice FROM admin WHERE AdminName=?"
        cursor.execute(statement, [AdminName])
    return cursor.fetchone()


def get_all_products():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM admin"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}


def delete_product(AdminID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM admin WHERE AdminID = ?"
    cursor.execute(statement, [AdminID])
    db.commit()
    return {"status": 201, "message": "item successfully deleted"}


def delete_account():
    pass
