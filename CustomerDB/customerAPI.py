from flask import Flask, jsonify, request
import CUSTOMER1
from customerdb1 import create_tables


app = Flask(__name__)


@app.route('/Products', methods=["GET"])
def  get_products():
    Products = CUSTOMER1.get_all_products()
    return jsonify(Products)


@app.route('/Product/<get_param>', methods=["GET"])
def  get_specific_product(get_param):
    Product = CUSTOMER1.get_product(get_param)
    return jsonify(Product)


@app.route('/Product', methods=["PUT"])
def  update_product():
    product_details = request.get_json()
    CustomerID = product_details["CustomerID"]
    CustomerName = product_details["CustomerName"]
    CustomerEmail = product_details["CustomerEmail"]
    CustomerPhoneNo = product_details["CustomerPhoneNo"]
    CustomerPassword = product_details["CustomerPassword"]
    CustomerAddress = product_details["CustomerAddress"]
   
    result = CUSTOMER1.update(CustomerID, CustomerName, CustomerEmail, CustomerPhoneNo,CustomerPassword, CustomerAddress)
    return jsonify(result)


app = Flask(__name__)


@app.route('/Products', methods=["GET"])
def  get_products():
    Products = CUSTOMER1.get_all_products()
    return jsonify(Products)


@app.route('/Product/<get_param>', methods=["GET"])
def  get_specific_product(get_param):
    Product = CUSTOMER1.get_product(get_param)
    return jsonify(Product)


@app.route('/Product', methods=["PUT"])
def  update_product():
    product_details = request.get_json()
    CustomerID = product_details["CustomerID"]
    CustomerName = product_details["CustomerName"]
    CustomerEmail = product_details["CustomerEmail"]
    CustomerPhoneNo = product_details["CustomerPhoneNo"]
    CustomerPassword = product_details["CustomerPassword"]
    CustomerAddress = product_details["CustomerAddress"]
    Product = product_details["Product"]
    ProductCategory = product_details["ProductCategory"]
    ProductPicture = product_details["ProductPicture"]
    ProductPrice = product_details["ProductPrice"]
    result = CUSTOMER1.update(CustomerID, CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress, Product, ProductCategory, ProductPicture, ProductPrice)
    return jsonify(result)


@app.route("/Product/<CustomerID>", methods=["DELETE"])
def  delete_specific_product(CustomerID):
    result = CUSTOMER1.delete_product(CustomerID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def  insert_product():
    product_details = request.get_json()
    CustomerName = product_details["CustomerName"]
    CustomerEmail = product_details["CustomerEmail"]
    CustomerPhoneNo = product_details["CustomerPhoneNo"]
    CustomerPassword = product_details["CustomerPassword"]
    CustomerAddress = product_details["CustomerAddress"]
   
    result = CUSTOMER1.insert(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress)
    return jsonify(result)





@app.route("/Product/<CustomerID>", methods=["DELETE"])
def  delete_specific_product(CustomerID):
    result = CUSTOMER1.delete_product(CustomerID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def  insert_product():
    product_details = request.get_json()
    CustomerName = product_details["CustomerName"]
    CustomerEmail = product_details["CustomerEmail"]
    CustomerPhoneNo = product_details["CustomerPhoneNo"]
    CustomerPassword = product_details["CustomerPassword"]
    CustomerAddress = product_details["CustomerAddress"]
    
    result = CUSTOMER1.insert(CustomerName, CustomerEmail, CustomerPhoneNo, CustomerPassword, CustomerAddress)
    return jsonify(result)


if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)
