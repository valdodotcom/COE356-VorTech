from db import get_db

""" UPDATE, INSERT, DELETE, GET"""

#The get_all functions in this list will give you information on all things in the database pertaining to that one field
#If we want to see the information pertaining to a single customer or vendor, we''ll use a different keyword





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE VendorInfo TABLE 


def insert_vendor_info(VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorPassword, VendorAddress):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO VendorInfo(VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorPassword, VendorAddress) VALUES (?,?,?,?,?,?,?,?)"
    cursor.execute(statement, [VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo,
                   VendorPassword, VendorAddress])
    db.commit()
    return {"status": 201, "message": "Record inserted into database"}
    ##this function allows for an Vendor to enter the information when signing up


def update_vendor_info(VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorPassword, VendorAddress, VendorID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE VendorInfo SET VendorFirstName=?, VendorLastName=?, VendorEmail=?, ShopName=?, ShopPicture=?, VendorPhoneNo=?, VendorPassword=?, VendorAddress=? WHERE VendorID=?"
    cursor.execute(statement, [VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorPassword, VendorAddress, VendorID])
    db.commit()
    return {"status": 202, "message": "update complete"}
    ##this will allow vendors to update personal information



def get_vendor_info_id(VendorID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorAddress FROM VendorInfo WHERE VendorID=?"
    cursor.execute(statement, [VendorID])
    result = cursor.fetchone()
    return  {
               "VendorFirstName": f"{result[0]}",
               "VendorLastName" : result[1],
                "VendorEmail": result[2],
                "ShopName" : result[3],
                "VendorPhoneNo": result[4],
                "VendorAddress": result[5] 
            }    
    
##to get a vendor's information by typing their ID or name or even selecting by tapping a button
##so far this search only works when you search with an ID rather than name
##consider creating a new function and endpoint for searching by name


# def get_vendor_info_name(VendorFirstName=None):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "SELECT VendorFirstName, VendorLastName, VendorEmail, ShopName, VendorPhoneNo, VendorAddress FROM VendorInfo WHERE VendorFirstName=?"
#     cursor.execute(statement, [VendorFirstName])
#     result = cursor.fetchone()
#     return {   
#                 "VendorFirstName": f"{result[0]}",
#                 "VendorLastName" : result[1],
#                 "VendorEmail": result[2],
#                 "ShopName" : result[3],
#                 "VendorPhoneNo": result[4],
#                 "VendorAddress": result[5] 
#             }    
    


def get_all_vendors():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM VendorInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "VendorID": f"{resultItem[0]}",
                "VendorFirstName": resultItem[1],
                "VendorLastName" : resultItem[2],
                "ShopName": resultItem[3],
                "ShopPicture" : resultItem[4],
                "VendorEmail" : resultItem[5],
                "VendorPhoneNo": resultItem[6],
                "VendorPassword": resultItem[7],
                "VendorAddress": resultItem[8] 
            }
        )
    return resultDict
    ##this will allow you to see all items on the VendorInfo table


# def delete_account(VendorID):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "DELETE FROM VendorInfo WHERE VendorID = ?"
#     cursor.execute(statement, [VendorID])
#     db.commit()
#     return {"status": 201, "message": "item successfully deleted"}
##this portion will allow us to delete a vendor's account information from the system. Upon discussions it was decided that this will not be used


def authorize_vendor_login(VendorEmail, VendorPassword):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM VendorInfo WHERE VendorEmail = ? AND VendorPassword =?"
    cursor.execute(query, [VendorEmail, VendorPassword])
    result = cursor.fetchone()
    if result:
        return 'Verified. Welcome'
    else:
        return 'Wrong E-mail or Password. Please try again'


def get_shop_info(ShopName=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT VendorFirstName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo, VendorAddress FROM VendorInfo WHERE ShopName=?"
    cursor.execute(statement, [ShopName])
    result = cursor.fetchone()
    return {
               "VendorFirstName": f"{result[0]}",
                "VendorEmail": result[1],
                "ShopName" : result[2],
                "ShopPicture" : result[3],
                "VendorPhoneNo": result[4],
                "VendorAddress": result[5] 
            }







##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE CustomerInfo TABLE 


def insert_customer(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO CustomerInfo(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress) VALUES (?,?,?,?,?,?)"
    cursor.execute(statement, [CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress])
    db.commit()
    return {"status": 201, "message": "Customer added into database"}


def update_customer(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE CustomerInfo SET CustomerFirstName=?, CustomerLastName=?, CustomerEmail=?, CustomerPhoneNo=?, CustomerPassword=?, CustomerAddress=? WHERE CustomerID=?"
    cursor.execute(statement, [CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo,
                   CustomerPassword, CustomerAddress, CustomerID])
    db.commit()
    return {"status": 202, "message": "Customer info update complete"}


def get_customer(CustomerID=None):
    db = get_db()
    cursor = db.cursor()
    if CustomerID:
        statement = "SELECT CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerAddress FROM CustomerInfo WHERE CustomerID=?"
        cursor.execute(statement, [CustomerID])
    # if CustomerFirstName:
    #     statement = "SELECT CustomerFirstName, CustomerEmail, CustomerPhoneNo, CustomerAddress FROM CustomerInfo WHERE CustomerFirstName=?"
    #     cursor.execute(statement, [CustomerFirstName])
    result = cursor.fetchone()
    return {
               "CustomerFirstName": f"{result[0]}",
               "CustomerLastName" : result[1],
                "CustomerEmail": result[2],
                "CustomerPhoneNo": result[3],
                "CustomerAddress": result[4] 
            }    
    


def get_all_customers():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM CustomerInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "CustomerID": f"{resultItem[0]}",
                "CustomerFirstName": resultItem[1],
                "CustomerLastName" : resultItem[2],
                "CustomerEmail": resultItem[3],
                "CustomerPhoneNo": resultItem[4],
                "CustomerPassword": resultItem[5],
                "CustomerAddress": resultItem[6] 
            }
        )
    return resultDict
    ##this will allow you to see all items on the CustomerInfo table


def authorize_customer_login(CustomerEmail, CustomerPassword):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM CustomerInfo WHERE CustomerEmail = ? AND CustomerPassword =?"
    cursor.execute(query, [CustomerEmail, CustomerPassword])
    result = cursor.fetchone()
    if result:
        return result[0]

    ##this will be used to authenticate login details entered by a customer





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE ProductInfo TABLE 

def insert_product_info(VendorID, Product ,ProductCategory, ProductPicture, ProductPrice, ProductDescription):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO ProductInfo(VendorID, Product, ProductCategory, ProductPicture, ProductPrice, ProductDescription) VALUES (?,?,?,?,?,?)"
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
    statement = "SELECT ProductID, Product, ProductCategory, ProductPrice, ProductPicture, ProductDescription, VendorID FROM ProductInfo WHERE ProductID=?"
    cursor.execute(statement, [ProductID])
    result = cursor.fetchone()
    return {{
                "ProductID": f"{result[0]}",
                "Product": result[1],
                "ProductCategory": result[2],
                "ProductPrice": result[3],
                "ProductPicture": result[4],
                "ProductDescription": result[5],
                "VendorID" : result[6]
            }
    
    }
    ##to get product information by clicking on it's picture, or name. Front end will sort that out
     

# def delete_product(ProductID):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "DELETE FROM ProductInfo WHERE ProductID = ?"
#     cursor.execute(statement, [ProductID])
#     db.commit()
#     return {"status": 201, "message": "item successfully deleted"}
    ##to delete a product sold by a vendor. It will not be used


def get_all_products():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM ProductInfo"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "ProductID": f"{resultItem[0]}",
                "VendorID": resultItem[1],
                "Product": resultItem[2],
                "ProductCategory": resultItem[3],
                "ProductPicture": resultItem[4],
                "ProductPrice": resultItem[5],
                "ProductDescription" : resultItem[6]
            }
        )
    return resultDict
    ##this will allow you to see all items in the ProductInfo table


def view_vendor_products(VendorID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT Product, ProductCategory, ProductPrice, ProductPicture, ProductDescription FROM ProductInfo WHERE VendorID=?"
    cursor.execute(statement, [VendorID])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "Product": f"{resultItem[0]}",
                "ProductCategory": resultItem[1],
                "ProductPrice": resultItem[2],
                "ProductPicture": resultItem[3],
                "ProductDescription" : resultItem[4]
            }
        )
    return resultDict
    ##THIS VIEW WILL GIVE YOU THE LIST OF ALL PRODUCTS BEING SOLD BY A VENDOR


def view_shop_products(ShopName):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ShopName, ShopPicture, ProductID, Product, ProductCategory, ProductPrice, ProductPicture, ProductDescription FROM VendorInfo v, ProductInfo p WHERE p.VendorID=v.VendorID AND ShopName=?"
    cursor.execute(statement, [ShopName])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {

                "ShopName": f"{resultItem[0]}",
                "ShopPicture" : resultItem[1],
                "ProductID": resultItem[2],
                "Product": resultItem[3],
                "ProductCategory": resultItem[4],
                "ProductPrice": resultItem[5],
                "ProductPicture": resultItem[6],
                "ProductDescription" : resultItem[7]
            }
        )
    return resultDict
    ##THIS VIEW WILL ALLOW YOU TO SEE ALL THE PRODUCTS A SHOP HAS



def get_shop_by_category(ProductCategory):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT ProductCategory, ShopName, ShopPicture FROM ProductInfo p, VendorInfo v WHERE p.VendorID = v.VendorID AND p.ProductCategory=?"
    cursor.execute(query, [ProductCategory])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "ProductCategory": f"{resultItem[0]}",
                "ShopName" : resultItem[1],
                "ShopPicture": resultItem[2]
            }
        )
    return resultDict
    ##THIS VIEW WILL ALLOW YOU TO SEE THE SHOPS THAT SELL PRODUCTS UNDER A CERTAIN CATEGORY



def get_product_by_category(ProductCategory):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT Product, ProductPicture, ProductPrice, ProductDescription, ShopName FROM ProductInfo p, VendorInfo v WHERE p.VendorID = v.VendorID AND p.ProductCategory=?"
    cursor.execute(query, [ProductCategory])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {

                "Product": f"{resultItem[0]}",
                "ProductPicture": resultItem[1],
                "ProductPrice": resultItem[2],
                "ShopName": resultItem[3],
                "ProductDescription": resultItem[4]
            }
        )
    return resultDict
##THIS VIEW WILL ALLOW YOU TO SEE THE LIST OF ALL PRODUCTS BEING SOLD UNDER A GIVEN CATEGORY




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
    statement = "SELECT WishlistID, ProductID, CustomerID FROM Wishlist WHERE WishlistID=?"
    cursor.execute(statement, [WishlistID])
    result = cursor.fetchone()
    return {
               "WishlistID" :f"{result[0]}",
               "ProductID": result[1],
                "CustomerID": result[2]
            }    
    ##to see a particular item on a customer's wishlist


def get_all_products_on_wishlist():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Wishlist"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "WishlistID": f"{resultItem[0]}",
                "ProductID": resultItem[1],
                "CustomerID": resultItem[2] 
            }
        )
    return resultDict
    ##this will allow you to see all items on the wishlist table
    

def delete_from_wishlist(WishlistID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Wishlist WHERE WishlistID = ?"
    cursor.execute(statement, [WishlistID])
    db.commit()
    return {"status": 201, "message": "item successfully deleted"}
    ##this allows a user to remove a product from their wishlist


def delete_customer_wishlist(CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Wishlist WHERE CustomerID = ?"
    cursor.execute(statement, [CustomerID])
    db.commit()
    return {"status": 201, "message": "wishlist successfully cleared"}
    ##this allows a user to remove all products from their wishlist


def view_wishlist_item(WishlistID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT WishlistID, Product, ProductPicture, ProductPrice, ProductDescription, ShopName FROM Wishlist w, ProductInfo p, VendorInfo v WHERE w.ProductID = p.ProductID AND p.VendorID = v.VendorID AND WishlistID = ?"
    cursor.execute(statement, [WishlistID])
    result = cursor.fetchone()
    return {
        "WishlistID": f"{result[0]}",
        "Product": result[1],
        "ProductPicture": result[2],
        "ProductPrice": result[3],
        "ProductDescription": result[4],
        "ShopName": result[5]
    }
    ##THIS VIEW WILL ALLOW A CUSTOMER TO SEE A PARTICULAR PRODUCT ON THEIR WISHLIST AS WELL AS IT'S INFORMATION






def view_wishlist(CustomerID):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT w.WishlistID, c.CustomerID, c.CustomerFirstName, c.CustomerLastName, p.ProductID, p.Product, p.ProductPicture, p.ProductPrice, v.ShopName FROM Wishlist w, CustomerInfo c ,ProductInfo p, VendorInfo v WHERE w.ProductID = p.ProductID AND w.CustomerID = c.CustomerID AND v.VendorID=p.VendorID AND c.CustomerID = ?"
    cursor.execute(query, [CustomerID])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "WishlistID": f"{resultItem[0]}",
                "CustomerID": resultItem[1],
                "CustomerFirstName": resultItem[2],
                "CustomerLastName" :resultItem[3],
                "ProductID": resultItem[4],
                "Product": resultItem[5],
                "ProductPicture": resultItem[6],
                "ProductPrice": resultItem[7],
                "ShopName": resultItem[8]
            }
        )
    return resultDict
    ##THIS VIEW WILL ALLOW YOU TO SEE A CUSTOMER'S WISHLIST





##THE FOLLOWING FUNCTIONS ALLOW FOR THE MANIPULATION OF DATA IN THE Cart TABLE


def insert_to_cart(ProductID, CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Cart(ProductID, CustomerID) VALUES (?,?)"
    cursor.execute(statement, [ProductID, CustomerID])
    db.commit()
    return {"status": 201, "message": "Added to cart"}
   ##this will allow a product to be added to the Cart table


def get_cart(CartID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT ProductID, CustomerID FROM Cart WHERE CartID=?"
    cursor.execute(statement, [CartID])
    result = cursor.fetchone()
    return {"status" : 200, "result": {
               "ProductID": f"{result[0]}",
                "CustomerID": result[1] 
            }    
    }
    ##this will allow you to see an item on the Cart table


def delete_from_cart(CartID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Cart WHERE CartID = ?"
    cursor.execute(statement, [CartID])
    db.commit()
    return {"status": 201, "message": "item removed from cart"}
    ##this allows a user to remove a product from their cart while shopping. 
    ##we should create a function that will delete every cart entry once shopping is done so it doesn't show up again later 

def delete_full_cart(CustomerID):
    db = get_db()
    cursor = db.cursor()
    statement = "DELETE FROM Cart WHERE CustomerID = ?"
    cursor.execute(statement, [CustomerID])
    db.commit()
    return {"status": 201, "message": "cart cleared successfully"}
    ##this will  allow you to clear everything off a customer's cart.
    ##it will be used when a customer decides to clear the cart as well as after a purchase has been confirmed


def get_all_products_on_cart():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Cart"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "CartID": f"{resultItem[0]}",
                "ProductID": resultItem[1],
                "CustomerID": resultItem[2] 
            }
        )
    return resultDict
    ##this will allow you to see all items on the cart table


def view_cart(CustomerID):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT ca.CartID, c.CustomerID, c.CustomerFirstName, c.CustomerLastName, p.ProductID, p.Product, p.ProductPrice, p.ProductPicture FROM Cart ca, CustomerInfo c, ProductInfo p WHERE ca.ProductID = p.ProductID AND ca.CustomerID = c.CustomerID and c.CustomerID = ?"
    cursor.execute(query, [CustomerID])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "CartID": f"{resultItem[0]}",
                "CustomerID": resultItem[1],
                "CustomerFirstName": resultItem[2],
                "CustomerLastName" :resultItem[3],
                "ProductID" : resultItem[4],
                "Product": resultItem[5],
                "ProductPrice": resultItem[6],
                "ProductPicture": resultItem[7]
            }
        )
    return resultDict
    ##THIS VIEW WILL ALLOW YOU TO SEE A CUSTOMER'S CART






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
    return {
               "ProductID": f"{result[0]}",
                "CustomerID": result[1],
                "OrderDate": result[2]
            }    
    ##this will allow you to see a particular order history


def get_all_order_history():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM OrderHistory"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "OrderID": f"{resultItem[0]}",
                "ProductID": resultItem[1],
                "CustomerID": resultItem[2],
                "OrderDate": resultItem[3]
            }
        )
    return resultDict
    ##this will allow you to see all purchases ever made 


def view_customer_history(CustomerID):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT o.OrderID, v.VendorID, v.VendorFirstName, v.VendorLastName, c.CustomerID, c.CustomerFirstName, c.CustomerLastName, p.Product, p.ProductPrice, p.ProductPicture, o.OrderDate FROM OrderHistory o, VendorInfo v, CustomerInfo c, ProductInfo p WHERE o.CustomerID = c.CustomerID AND o.ProductID = p.ProductID AND p.VendorID = v.VendorID AND c.CustomerID=?"
    cursor.execute(query, [CustomerID])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "OrderID": f"{resultItem[0]}",
                "VendorID": resultItem[1],
                "VendorFirstName": resultItem[2],
                "VendorLastName" :resultItem[3],
                "CustomerID": resultItem[4],
                "CustomerFirstName": resultItem[5],
                "CustomerLastName" :resultItem[6],
                "Product": resultItem[7],
                "ProductPrice": resultItem[8],
                "ProductPicture" : resultItem[9],
                "OrderDate": resultItem[10]
            }
        )
    return resultDict
    ##THIS WILL ALLOW YOU TO SEE A CUSTOMER'S HISTORY OF PURCHASES


def view_vendor_history(VendorID):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT o.OrderID, v.VendorID, v.VendorFirstName, v.VendorLastName, c.CustomerID, c.CustomerFirstName, c.CustomerLastName, p.Product, p.ProductPrice, p.ProductPicture, o.OrderDate FROM OrderHistory o, VendorInfo v, CustomerInfo c, ProductInfo p WHERE o.CustomerID = c.CustomerID AND o.ProductID = p.ProductID AND p.VendorID = v.VendorID AND v.VendorID=?"
    cursor.execute(query, [VendorID])
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
                "OrderID": f"{resultItem[0]}",
                "VendorID": resultItem[1],
                "VendorFirstName": resultItem[2],
                "VendorLastName" :resultItem[3],
                "CustomerID": resultItem[4],
                "CustomerFirstName": resultItem[5],
                "CustomerLastName" :resultItem[6],
                "Product": resultItem[7],
                "ProductPrice": resultItem[8],
                "ProductPicture" : resultItem[9],
                "OrderDate": resultItem[10]
            }
        )
    return resultDict
    ##THIS VIEW WILL ALLOW YOU TO SEE A VENDOR'S HISTORY OF SALES