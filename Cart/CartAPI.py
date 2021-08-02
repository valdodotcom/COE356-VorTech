from flask import Flask, jsonify, request
import Cart
from Cartdb1 import create_tables


app = Flask(__name__)


@app.route('/Products', methods=["GET"])
def  get_products():
    Products = Cart.get_all_products()
    return jsonify(Products)


@app.route('/Product/<get_param>', methods=["GET"])
def  get_specific_product(get_param):
    Product = Cart.get_product(get_param)
    return jsonify(Product)




app = Flask(__name__)


@app.route('/Products', methods=["GET"])
def  get_products():
    Products = Cart.get_all_products()
    return jsonify(Products)


@app.route('/Product/<get_param>', methods=["GET"])
def  get_specific_product(get_param):
    Product = Cart.get_product(get_param)
    return jsonify(Product)




@app.route("/Product/<CustomerID>", methods=["DELETE"])
def  delete_specific_product(CustomerID):
    result = Cart.delete_product(CustomerID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def  insert_product():
    product_details = request.get_json()
    CustomerID = product_details["CustomerID"]
    VendorID = product_details["VendorID"]
    ProductForSale = product_details["ProductForSale"]
    ProductCategory= product_details["ProductCategory"]
    ProductImage = product_details["ProductImage"]
    Price = product_details["Price"]
   
    result = Cart.insert(VendorID, ProductForSale, ProductCategory, ProductImage, Price)
    return jsonify(result)





@app.route("/Product/<CustomerID>", methods=["DELETE"])
def  delete_specific_product(CustomerID):
    result = Cart.delete_product(CustomerID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def  insert_product():
    product_details = request.get_json()
    VendorID = product_details["VendorID"]
    ProductForSale = product_details["ProductForSale"]
    ProductCategory= product_details["ProductCategory"]
    ProductImage = product_details["ProductImage"]
    Price = product_details["Price"]
    
    result = Cart.insert(VendorID, ProductForSale, ProductCategory, ProductImage, Price)
    return jsonify(result)


if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)
