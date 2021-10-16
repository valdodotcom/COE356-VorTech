from flask import Flask, jsonify, request
import admin
from db import create_tables

##note that each endpoint corresponds to a function to access data in the admin file


app = Flask(__name__)






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE VendorInfo TABLE


@app.route("/new-vendor-info", methods=["POST"])
def insert_vendor_information():
    vendor_details = request.get_json()
    VendorFirstName = vendor_details["VendorFirstName"]
    VendorLastName = vendor_details["VendorLastName"]
    VendorEmail = vendor_details["VendorEmail"]
    ShopName = vendor_details["ShopName"]
    ShopPicture = vendor_details["ShopPicture"]
    VendorPhoneNo = vendor_details["VendorPhoneNo"]
    VendorPassword = vendor_details["VendorPassword"]
    VendorAddress = vendor_details["VendorAddress"]
    result = admin.insert_vendor_info(VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo,
                          VendorPassword, VendorAddress)
    return jsonify(result)
    ##this is the endpoint for inserting data to the VendorInfo table. This will be used when users sign up as vendors


@app.route("/update-vendor-info", methods=["PUT"])
def update_vendor_information():
    vendor_details = request.get_json()
    VendorFirstName = vendor_details["VendorFirstName"]
    VendorLastName = vendor_details["VendorLastName"]
    VendorEmail = vendor_details["VendorEmail"]
    ShopName = vendor_details["ShopName"]
    ShopPicture = vendor_details["ShopPicture"]
    VendorPhoneNo = vendor_details["VendorPhoneNo"]
    VendorPassword = vendor_details["VendorPassword"]
    VendorAddress = vendor_details["VendorAddress"]
    VendorID = vendor_details["VendorID"]
    result = admin.update_vendor_info(VendorFirstName, VendorLastName, VendorEmail, ShopName, ShopPicture, VendorPhoneNo,
                          VendorPassword, VendorAddress,VendorID)
    return jsonify(result)
    ##this is the endpoint for updating data in the VendorInfo. This will allow vendors to change their personal information


# @app.route('/get-vendor-info/name/<VendorFirstName>', methods=["GET"])
# def get_specific_vendor_name(VendorFirstName):
#     Vendor = admin.get_vendor_info_name(VendorFirstName)
#     return jsonify(Vendor)
#     ##this is the endpoint for getting a vendor's information using their name. Inasmuch as it is functional, it will not be used


@app.route('/get-vendor-info/id/<VendorID>', methods=["GET"])
def get_specific_vendor_id(VendorID):
    Vendor = admin.get_vendor_info_id(VendorID)
    return jsonify(Vendor)
    ##this is the endpoint for getting a vendor's information using their ID


@app.route('/get-all-vendors', methods=["GET"])
def get_vendors():
    vendors = admin.get_all_vendors()
    return jsonify(vendors)
    ##this endpoint will allow you to see information on all vendors in the database


@app.route('/get-shop-info/name/<ShopName>', methods=["GET"])
def get_specific_shop_info(ShopName):
    Shop = admin.get_shop_info(ShopName)
    return jsonify(Shop)
##this endpoint will allow you to view a shop's information including the vendor's information


# @app.route("/delete-vendor/<VendorID>", methods=["DELETE"])
# def delete_vendor_account(VendorID):
#     result = admin.delete_account(VendorID)
#     return jsonify(result)
##this endpoint is for deleting a vendor's account. It is functional but it will not be used

@app.route('/vendor-login', methods=["POST"])
def vendor_login():
    login = request.get_json()
    VendorEmail = login["VendorEmail"]
    VendorPassword =login["VendorPassword"]
    result = admin.authorize_vendor_login(VendorEmail, VendorPassword)
    return jsonify(result)
    ##this is the endpoint for authenticating a vendor's login



## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE CustomerInfo TABLE


@app.route("/new-customer-info", methods=["POST"])
def  insert_customer_info():
    customer_details = request.get_json()
    CustomerFirstName = customer_details["CustomerFirstName"]
    CustomerLastName = customer_details["CustomerLastName"]
    CustomerEmail = customer_details["CustomerEmail"]
    CustomerPhoneNo = customer_details["CustomerPhoneNo"]
    CustomerPassword = customer_details["CustomerPassword"]
    CustomerAddress = customer_details["CustomerAddress"]   
    result = admin.insert_customer(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress)
    return jsonify(result)
    ##this is the endpoint for inserting data to the CustomerInfo table. This will be used when users sign up as customers


@app.route('/update-customer-info', methods=["PUT"])
def  update_customer_info():
    customer_details = request.get_json()
    CustomerFirstName = customer_details["CustomerFirstName"]
    CustomerLastName = customer_details["CustomerLastName"]
    CustomerEmail = customer_details["CustomerEmail"]
    CustomerPhoneNo = customer_details["CustomerPhoneNo"]
    CustomerPassword = customer_details["CustomerPassword"]
    CustomerAddress = customer_details["CustomerAddress"]
    CustomerID = customer_details["CustomerID"]
    result = admin.update_customer(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, CustomerID)
    return jsonify(result)


@app.route('/get-customer-info/<get_param>', methods=["GET"]) ##so far this search only works when you search with an ID rather than name
def  get_specific_customer(get_param):               ##consider creating a new function and endpoint for searching by name
    Product = admin.get_customer(get_param)
    return jsonify(Product)


@app.route('/get-all-customers', methods=["GET"])
def get_customers():
    customers = admin.get_all_customers()
    return jsonify(customers)
    ##this endpoint will allow you to see information on all customers in the database


@app.route('/customer-login', methods=["POST"])
def customer_login():
    login = request.get_json()
    CustomerEmail = login["CustomerEmail"]
    CustomerPassword =login["CustomerPassword"]
    result = admin.authorize_customer_login(CustomerEmail, CustomerPassword)
    return jsonify(result)
    ##this is the endpoint for authenticating login credentials entered by a customer







## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE ProductInfo TABLE

@app.route("/new-product-info", methods=["POST"])
def insert_product_information():
    product_details = request.get_json()
    VendorID = product_details["VendorID"]
    Product = product_details["Product"]
    ProductCategory = product_details["ProductCategory"]
    ProductPicture = product_details["ProductPicture"]
    ProductPrice = product_details["ProductPrice"]
    ProductDescription = product_details["ProductDescription"]
    result = admin.insert_product_info(VendorID, Product, ProductCategory, ProductPicture, ProductPrice,ProductDescription)
    return jsonify(result)
    ##this is the endpoint for adding a new product to the ProductInfo table.


@app.route("/update-product-info", methods=["PUT"])
def update_product_info():
    product_details = request.get_json()
    Product = product_details["Product"]
    ProductCategory = product_details["ProductCategory"]
    ProductPicture = product_details["ProductPicture"]
    ProductPrice = product_details["ProductPrice"]
    ProductDescription = product_details["ProductDescription"]
    ProductID = product_details["ProductID"]
    result = admin.update_product_info(Product, ProductCategory, ProductPicture, ProductPrice,ProductDescription, ProductID)
    return jsonify(result)
    ##this is the endpoint for updating a product's information in the ProductInfo table


@app.route('/get-product-info/<get_param>', methods=["GET"])
def get_specific_product(get_param):
    Product = admin.get_product_info(get_param)
    return jsonify(Product)
    ##this is the endpoint for viewing a product's details


# @app.route("/delete-product/<ProductID>", methods=["DELETE"])
# def delete_specific_product(ProductID):
#     result = admin.delete_product(ProductID)
#     return jsonify(result)
    ##this is the endpoint for deleting data from the productInfo table. It will also not be used


@app.route('/get-all-products', methods=["GET"])
def get_full_product_list():
    products = admin.get_all_products()
    return jsonify(products)
    ##this endpoint will allow you to see information on all products in the database


@app.route('/view-vendor-products/<VendorID>', methods=["GET"])
def get_vendor_products(VendorID):
    vendor_view = admin.view_vendor_products(VendorID)
    return jsonify(vendor_view)
    ##THIS ENDPOINT WILL GIVE YOU THE LIST OF ALL PRODUCTS BEING SOLD BY A VENDOR


@app.route('/view-shop-products/<ShopName>', methods=["GET"])
def get_products_in_shop(ShopName):
    shop_view = admin.view_shop_products(ShopName)
    return jsonify(shop_view)
##THIS ENDPOINT WILL ALLOW YOU TO VIEW A LIST OF ALL PRODUCTS IN A SHOP


@app.route('/get-shops/category/<ProductCategory>', methods=["GET"])
def get_shops_by_category(ProductCategory):
    shop_view = admin.get_shop_by_category(ProductCategory)
    return jsonify(shop_view)
    ##THIS ENDPOINT WILL ALLOW YOU TO VIEW ALL SHOPS SELLING PRODUCTS UNDER A CERTAIN CATEGORY


@app.route('/get-products/category/<ProductCategory>', methods=["GET"])
def get_products_by_category(ProductCategory):
    product_view = admin.get_product_by_category(ProductCategory)
    return jsonify(product_view)
    ##THIS ENDPOINT WILL ALLOW YOU TO VIEW ALL PRODUCTS UNDER A CERTAIN CATEGORY





## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE Wishlist TABLE

@app.route("/add-to-wishlist", methods=["POST"])
def add_to_wishlist():
    wishlist_details = request.get_json()
    ProductID = wishlist_details["ProductID"]
    CustomerID = wishlist_details["CustomerID"]
    result = admin.insert_to_wishlist(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the wishlist table


@app.route('/get-wishlist-item/<WishlistID>', methods=["GET"])
def get_specific_product_on_wishlist(WishlistID):
    WishlistProduct = admin.get_product_from_wishlist(WishlistID)
    return jsonify(WishlistProduct)
    ##this is the endpoint to get a specific product from the wishlist table


@app.route('/get-full-wishlist', methods=["GET"])
def get_full_wishlist():
    WishlistProducts = admin.get_all_products_on_wishlist()
    return jsonify(WishlistProducts)
    ##this endpoint will allow you to see information on all items placed on all customers' wishlists in the database


@app.route("/delete-wishlist-item/<WishlistID>", methods=["DELETE"])
def remove_from_wishlist(WishlistID):
    result = admin.delete_from_wishlist(WishlistID)
    return jsonify(result)
    ##this is the endpoint for deleting an item from the wishlist table


@app.route("/delete-full-wishlist/<CustomerID>", methods=["DELETE"])
def clear_customer_wishlist(CustomerID):
    result = admin.delete_customer_wishlist(CustomerID)
    return jsonify(result)
    ##this is the endpoint for deleting all items from a customer's wishlist


@app.route('/view-wishlist-item/<WishlistID>', methods=["GET"])
def view_specific_product_on_wishlist(WishlistID):
    WishlistProduct = admin.view_wishlist_item(WishlistID)
    return jsonify(WishlistProduct)
    ##this is the endpoint to get a specific product from the wishlist table


@app.route('/view-customer-wishlist/<CustomerID>', methods=["GET"])
def get_customer_view(CustomerID):
    customer_view = admin.view_wishlist(CustomerID)
    return jsonify(customer_view)
    ##THIS VIEW WILL ALLOW YOU TO SEE A CUSTOMER'S WISHLIST





## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE Cart TABLE


@app.route("/add-to-cart", methods=["POST"])
def add_to_cart():
    cart_details = request.get_json()
    ProductID = cart_details["ProductID"]
    CustomerID = cart_details["CustomerID"]
    result = admin.insert_to_cart(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the cart table


@app.route('/get-item-on-cart/<CartID>', methods=["GET"])
def get_specific_product_on_cart(CartID):
    cart_details = admin.get_cart(CartID)
    return jsonify(cart_details)
    ##this is the endpoint to get a specific product from the Cart table


@app.route("/delete-from-cart/<CartID>", methods=["DELETE"])
def remove_from_cart(CartID):
    result = admin.delete_from_cart(CartID)
    return jsonify(result)
    ##this is the endpoint for deleting an item from the Cart table

@app.route("/delete-customer-cart/<CustomerID>", methods=["DELETE"])
def remove_full_cart(CustomerID):
    result = admin.delete_full_cart(CustomerID)
    return jsonify(result)
    ##this is the endpoint for deleting all items in a customer's Cart


@app.route('/get-full-cart', methods=["GET"])
def get_carts():
    carts = admin.get_all_products_on_cart()
    return jsonify(carts)
    ##this endpoint will allow you to see all items put on Cart by all customers in the database


@app.route('/view-customer-cart/<CustomerID>', methods=["GET"])
def get_customer_cart(CustomerID):
    cart_view = admin.view_cart(CustomerID)
    return jsonify(cart_view)
    ##THIS ENDPOINT WILL ALLOW YOU TO SEE A CUSTOMER'S CART






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE OrderHistory TABLE


@app.route("/new-order-history", methods=["POST"])
def add_to_order_history():
    order_details = request.get_json()
    ProductID = order_details["ProductID"]
    CustomerID = order_details["CustomerID"]
    result = admin.add_to_history(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the order history table


@app.route('/get-order-history/<OrderID>', methods=["GET"])
def get_specific_history(OrderID):
    order_details = admin.get_particular_history(OrderID)
    return jsonify(order_details)
    ##this is the endpoint to get a specific product in the order history


@app.route('/get-full-history', methods=["GET"])
def get_all_history():
    history = admin.get_all_order_history()
    return jsonify(history)
    ##this endpoint will allow you to see the history of all purchases made in the database


@app.route('/view-customer-history/<CustomerID>', methods=["GET"])
def get_customer_history(CustomerID):
    history_view = admin.view_customer_history(CustomerID)
    return jsonify(history_view)
    ##THIS WILL ALLOW YOU TO SEE A CUSTOMER'S HISTORY OF PURCHASES

@app.route('/view-vendor-history/<VendorID>', methods=["GET"])
def get_vendor_history(VendorID):
    history_view = admin.view_vendor_history(VendorID)
    return jsonify(history_view)
    ##THIS ENDPOINT WILL ALLOW YOU TO SEE A VENDOR'S HISTORY OF SALES






if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True) 
