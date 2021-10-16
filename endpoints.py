from flask import Flask, jsonify, request
import admin
from db import create_tables

##note that each endpoint corresponds to a function to access data in the admin file


app = Flask(__name__)






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE VendorInfo TABLE


@app.route(“/insert-vendor-info”, methods=["POST"])
def insert_vendor_information():
    vendor_details = request.get_json()
    VendorName = vendor_details["VendorName"]
    VendorEmail = vendor_details["VendorEmail"]
    VendorPhoneNo = vendor_details["VendorPhoneNo"]
    VendorPassword = vendor_details["VendorPassword"]
    VendorAddress = vendor_details["VendorAddress"]
    result = admin.insert_vendor_info(VendorName, VendorEmail, VendorPhoneNo,
                          VendorPassword, VendorAddress)
    return jsonify(result)
    ##this is the endpoint for inserting data to the VendorInfo table


@app.route(“/update-vendor-info”, methods=["PUT"])
def update_vendor_information():
    vendor_details = request.get_json()
    VendorName = vendor_details["VendorName"]
    VendorEmail = vendor_details["VendorEmail"]
    VendorPhoneNo = vendor_details["VendorPhoneNo"]
    VendorPassword = vendor_details["VendorPassword"]
    VendorAddress = vendor_details["VendorAddress"]
    VendorID = vendor_details["VendorID"]
    result = admin.update_vendor_info(VendorName, VendorEmail, VendorPhoneNo,
                          VendorPassword, VendorAddress,VendorID)
    return jsonify(result)
    ##this is the endpoint for updating data in the VendorInfo


@app.route(‘/vendor-info-name/<VendorName>’, methods=["GET"])
def get_specific_vendor_name(VendorName):
    Vendor = admin.get_vendor_info_name(VendorName)
    return jsonify(Vendor)
    ##this is the endpoint for getting a vendor's information using their name


@app.route(‘/vendor_info_id/<VendorID>’, methods=["GET"])
def get_specific_vendor_id(VendorID):
    Vendor = admin.get_vendor_info_id(VendorID)
    return jsonify(Vendor)
    ##this is the endpoint for getting a vendor's information using their ID


@app.route(‘/show-vendor-info’, methods=["GET"])
def get_vendors():
    vendors = admin.get_all_vendors()
    return jsonify(vendors)
    ##this endpoint will allow you to see information on all vendors in the database






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE CustomerInfo TABLE


@app.route(“/insert-customer”, methods=["POST"])
def  insert_customer_info():
    customer_details = request.get_json()
    CustomerName = customer_details["CustomerName"]
    CustomerEmail = customer_details["CustomerEmail"]
    CustomerPhoneNo = customer_details["CustomerPhoneNo"]
    CustomerPassword = customer_details["CustomerPassword"]
    CustomerAddress = customer_details["CustomerAddress"]   
    result = admin.insert_customer(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress)
    return jsonify(result)


@app.route(‘/update-customer’, methods=["PUT"])
def  update_customer_info():
    customer_details = request.get_json()
    CustomerName = customer_details["CustomerName"]
    CustomerEmail = customer_details["CustomerEmail"]
    CustomerPhoneNo = customer_details["CustomerPhoneNo"]
    CustomerPassword = customer_details["CustomerPassword"]
    CustomerAddress = customer_details["CustomerAddress"]
    CustomerID = customer_details["CustomerID"]
    result = admin.update_customer(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, CustomerID)
    return jsonify(result)


@app.route(‘/search-customer-id/<get_param>’, methods=["GET"]) ##so far this search only works when you search with an ID rather than name
def  get_specific_customer(get_param):               ##consider creating a new function and endpoint for searching by name
    Product = admin.get_customer(get_param)
    return jsonify(Product)


@app.route(‘/show-customers’, methods=["GET"])
def get_customers():
    customers = admin.get_all_customers()
    return jsonify(customers)
     ##this endpoint will allow you to see information on all customers in the database






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE ProductInfo TABLE

@app.route(“/add-product-info”, methods=["POST"])
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
    ##this is the endpoint for adding a new product to the ProductInfo table


@app.route(“/update-product-info”, methods=["PUT"])
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


@app.route(‘/view-product-details/<get_param>’, methods=["GET"])
def get_specific_product(get_param):
    Product = admin.get_product_info(get_param)
    return jsonify(Product)
    ##this is the endpoint for viewing a product's details


@app.route(“/delete-product-data/<ProductID>”, methods=["DELETE"])
def delete_specific_product(ProductID):
    result = admin.delete_product(ProductID)
    return jsonify(result)
    ##this is the endpoint for deleting data from the productInfo table


@app.route(‘/show-products-info’, methods=["GET"])
def get_full_product_list():
    products = admin.get_all_products()
    return jsonify(products)
     ##this endpoint will allow you to see information on all products in the database






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE Wishlist TABLE

@app.route(“/add-to-wishlist”, methods=["POST"])
def add_to_wishlist():
    wishlist_details = request.get_json()
    ProductID = wishlist_details["ProductID"]
    CustomerID = wishlist_details["CustomerID"]
    result = admin.insert_to_wishlist(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the wishlist table


@app.route(‘/get-wishlist-product/<WishlistID>’, methods=["GET"])
def get_specific_product_on_wishlist(WishlistID):
    WishlistProduct = admin.get_product_from_wishlist(WishlistID)
    return jsonify(WishlistProduct)
    ##this is the endpoint to get a specific product from the wishlist table


@app.route(‘/show-wishlists-info‘, methods=["GET"])
def get_full_wishlist():
    WishlistProducts = admin.get_all_products_on_wishlist()
    return jsonify(WishlistProducts)
     ##this endpoint will allow you to see information on all items placed on all customers' wishlists in the database


@app.route(“/delete-wishlist/<WishlistID>", methods=["DELETE"])
def remove_from_wishlist(WishlistID):
    result = admin.delete_from_wishlist(WishlistID)
    return jsonify(result)
    ##this is the endpoint for deleting an item from the wishlist table





## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE Cart TABLE


@app.route(“/add-new-cart”, methods=["POST"])
def add_to_cart():
    cart_details = request.get_json()
    ProductID = cart_details["ProductID"]
    CustomerID = cart_details["CustomerID"]
    result = admin.insert_to_cart(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the cart table


@app.route(‘/get-cart-product/<CartID>’, methods=["GET"])
def get_specific_product_on_cart(CartID):
    cart_details = admin.get_cart(CartID)
    return jsonify(cart_details)
    ##this is the endpoint to get a specific product from the wishlist table


@app.route(“/delete-cart-item/<CartID>”, methods=["DELETE"])
def remove_from_cart(CartID):
    result = admin.delete_from_cart(CartID)
    return jsonify(result)
    ##this is the endpoint for deleting an item from the wishlist table


@app.route(‘/show-carts-customer-info’, methods=["GET"])
def get_carts():
    carts = admin.get_all_products_on_cart()
    return jsonify(carts)
    ##this endpoint will allow you to see information on all customers in the database






## THE FOLLOWING ENDPOINTS WILL RUN FOR FUNCTIONS IN THE OrderHistory TABLE


@app.route(“/add-to-order-history”, methods=["POST"])
def add_to_order_history():
    order_details = request.get_json()
    ProductID = order_details["ProductID"]
    CustomerID = order_details["CustomerID"]
    result = admin.add_to_history(ProductID, CustomerID)
    return jsonify(result)
    ##this is the endpoint for adding a new item to the order history table


@app.route(‘/get-order-history-product/<OrderID>’, methods=["GET"])
def get_specific_history(OrderID):
    order_details = admin.get_particular_history(OrderID)
    return jsonify(order_details)
    ##this is the endpoint to get a specific product in the order history


@app.route(‘/show-order-histories’, methods=["GET"])
def get_all_history():
    history = admin.get_all_order_history()
    return jsonify(history)
    ##this endpoint will allow you to see information on all customers in the database





if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)
