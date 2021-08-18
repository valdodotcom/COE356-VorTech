from db import get_db

""" UPDATE, INSERT, DELETE, GET"""

#The get_all functions in this list will give you information on all things in the database pertaining to that one field
#If we want to see the information pertaining to a single customer or vendor, we''ll use a different keyword





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE VendorInfo TABLE 


def insert_vendor_info(VendorName, VendorEmail, VendorPhoneNo, VendorPassword, VendorAddress):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO VendorInfo(VendorName, VendorEmail, VendorPhoneNo, VendorPassword, VendorAddress) VALUES (?,?,?,?,?)"
    cursor.execute(statement, [VendorName, VendorEmail, VendorPhoneNo,
                   VendorPassword, VendorAddress])
    db.commit()
    return {"status": 201, "message": "Record inserted into database"}
    ##this function allows for an Vendor to enter the information when signing up


def update_vendor_info(VendorName, VendorEmail, VendorPhoneNo, VendorPassword, VendorAddress, VendorID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE VendorInfo SET VendorName=?, VendorEmail=?, VendorPhoneNo=?, VendorPassword=?, VendorAddress=? WHERE VendorID=?"
    cursor.execute(statement, [VendorName, VendorEmail, VendorPhoneNo, VendorPassword, VendorAddress, VendorID])
    db.commit()
    return {"status": 202, "message": "update complete"}
    ##this will allow vendors to update personal information



def get_vendor_info_id(VendorID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT VendorName, VendorEmail, VendorPhoneNo, VendorAddress FROM VendorInfo WHERE VendorID=?"
    cursor.execute(statement, [VendorID])
    result = cursor.fetchone()
    return {"status":200, "result": result}
##to get a vendor's information by typing their ID or name or even selecting by tapping a button
##so far this search only works when you search with an ID rather than name
##consider creating a new function and endpoint for searching by name


def get_vendor_info_name(VendorName=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT VendorName, VendorEmail, VendorPhoneNo, VendorAddress FROM VendorInfo WHERE VendorName=?"
    cursor.execute(statement, [VendorName])
    result = cursor.fetchone()
    return {"status":200, "result": result}


def get_all_vendors():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM VendorInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all items on the VendorInfo table


def delete_account():
    pass





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE CustomerInfo TABLE 


def insert_customer(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO CustomerInfo(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress) VALUES (?,?,?,?,?)"
    cursor.execute(statement, [CustomerName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress])
    db.commit()
    return {"status": 201, "message": "Customer added into database"}


def update_customer(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE CustomerInfo SET CustomerName=?, CustomerEmail=?, CustomerPhoneNo=?, CustomerPassword=?, CustomerAddress=? WHERE CustomerID=?"
    cursor.execute(statement, [CustomerName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress, CustomerID])
    db.commit()
    return {"status": 202, "message": "Customer info update complete"}


def get_customer(CustomerID=None, CustomerName=None):
    db = get_db()
    cursor = db.cursor()
    if CustomerID:
        statement = "SELECT CustomerName, CustomerEmail, CustomerPhoneNo, CustomerAddress FROM CustomerInfo WHERE CustomerID=?"
        cursor.execute(statement, [CustomerID])
    if CustomerName:
        statement = "SELECT CustomerName, CustomerEmail, CustomerPhoneNo, CustomerAddress FROM CustomerInfo WHERE CustomerName=?"
        cursor.execute(statement, [CustomerName])
    result = cursor.fetchone()
    return {"status":200, "result": result}


def get_all_customers():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM CustomerInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all items on the CustomerInfo table





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE ProductInfo TABLE 

def insert_product_info(VendorID, Product ,ProductCategory, ProductPicture, ProductPrice, ProductDescription):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO ProductInfo(VendorID, Product, ProductCategory, ProductPicture, ProductPrice, ProductDescription) VALUES (?,?,?,?,?,?,?)"
    cursor.execute(statement, [VendorID, Product, ProductCategory, ProductPicture, ProductPrice, ProductDescription])
    db.commit()
    return {"status": 201, "message": "Product inserted into database"}
    ##this function allows for an Vendor to enter product information


def update_product_info(Product, ProductCategory, ProductPicture, ProductPrice, ProductDescription, ProductID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE ProductInfo SET Product=?, ProductCategory=?, ProductPicture=?, ProductPrice=?, ProductDescription=? WHERE ProductID=?"
    cursor.execute(statement, [Product, ProductCategory, ProductPicture, ProductPrice, ProductDescription, ProductID])
    db.commit()
    return {"status": 202, "message": "product info update complete"}
    ##to update information about products for sale


def get_product_info(ProductID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ProductID, Product, ProductCategory, ProductPrice, ProductPicture, ProductDescription, VendorID FROM ProductInfo WHERE Product=?"
    cursor.execute(statement, [ProductID])
    result = cursor.fetchone()
    return {"status":200, "result": result}
    ##to get product information by clicking on it's picture, or name
     

def delete_product(ProductID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM ProductInfo WHERE ProductID = ?"
    cursor.execute(statement, [ProductID])
    db.commit()
    return {"status": 201, "message": "item successfully deleted"}
    ##to delete a product sold by a vendor. Only vendors will be able to do this


def get_all_products():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM ProductInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all items on the ProductInfo table






##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE Wishlist TABLE


def insert_to_wishlist(ProductID, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Wishlist(ProductID, CustomerID) VALUES (?,?)"
    cursor.execute(statement, [ProductID, CustomerID])
    db.commit()
    return {"status": 201, "message": "Added to wishlist"}
    ##this function allows for a customer to add a new product to their wishlist


def get_product_from_wishlist(WishlistID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ProductID, CustomerID FROM Wishlist WHERE WishlistID=?"
    cursor.execute(statement, [WishlistID])
    result = cursor.fetchone()
    return {"status":200, "result": result}
    ##to see a particular item on a customer's wishlist including it's information


def get_all_products_on_wishlist():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Wishlist"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all items on the wishlist table
    

def delete_from_wishlist(WishlistID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Wishlist WHERE WishlistID = ?"
    cursor.execute(statement, [WishlistID])
    db.commit()
    return {"status": 201, "message": "item successfully deleted"}
    ##this allows a user to remove a product from their wishlist 





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE Cart TABLE


def insert_to_cart(ProductID, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Cart(ProductID, CustomerID) VALUES (?,?)"
    cursor.execute(statement, [ProductID, CustomerID])
    db.commit()
    return {"status": 201, "message": "Added to cart"}


def get_cart(CartID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ProductID, CustomerID FROM Cart WHERE CartID=?"
    cursor.execute(statement, [CartID])
    result = cursor.fetchone()
    return {"status":200, "result": result}    


def delete_from_cart(CartID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Cart WHERE CartID = ?"
    cursor.execute(statement, [CartID])
    db.commit()
    return {"status": 201, "message": "item removed from cart"}
    ##this allows a user to remove a product from their cart while shopping. 
    ##we should create a function that will delete every cart entry once shopping is done so it doesn't show up again later 


def get_all_products_on_cart():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Cart"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all items on the wishlist table






##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE OrderHistory TABLE


def add_to_history(ProductID, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO OrderHistory(ProductID, CustomerID) VALUES (?,?)"
    cursor.execute(statement, [ProductID, CustomerID])
    db.commit()
    return {"status": 201, "message": "Added to Order History"}
    ##this function allows for a customer to add a new product to the order history once the order is confirmed
    

def get_particular_history(OrderID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ProductID, CustomerID, OrderDate FROM OrderHistory WHERE OrderID=?"
    cursor.execute(statement, [OrderID])
    result = cursor.fetchone()
    return {"status":200, "result": result}
    ##this will allow you to see a particular order history


def get_all_order_history():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM OrderHistory"
    cursor.execute(query)
    result = cursor.fetchall()
    return {"status": 200, "result": result}
    ##this will allow you to see all purchases ever made 






