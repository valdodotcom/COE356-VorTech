from flask import Flask, jsonify, request

from db import Database

app = Flask(__name__)



@app.route('/Products', methods=["GET"])
def get_product():
    Product = Database.get_all_product()
    return jsonify(Product)


@app.route('/Product/<get_param>', methods=["GET"])
def get_specific_product(get_param):
    Product = Database.get_product(get_param)
    return jsonify(Product)


@app.route('/Product', methods=["PUT"])
def update_product():
    product_details = request.get_json()
    customer_id = product_details["CustomerID"]
    admin_id = product_details["AdminID"]
    product_for_sale = product_details["Product"]
    product_category = product_details["ProductCategory"]
    picture_of_product = product_details["ProductPicture"]
    result = Database.update(CustomerID, AdminID, Product, ProductCategory, ProductPicture)
    return jsonify(result)


@app.route("/Product/<CustomerID>", methods=["DELETE"])
def delete_specific_product(CustomerID):
    result = Database.delete_product(CustomerID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def insert_product():
    product_details = request.get_json()
    customer_id = product_details["CustomerID"]
    admin_id = product_details["AdminID"]
    product_for_sale = product_details["Product"]
    product_category = product_details["ProductCategory"]
    picture_of_product = product_details["ProductPicture"]
    result = Database.update(CustomerID, AdminID, Product, ProductCategory, ProductPicture)
    return (result)


if __name__ == "__WishList__":
    Database()
    app.run(host='0.0.0.0', port=8000, debug=True)
