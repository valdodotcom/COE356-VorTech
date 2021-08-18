from flask import Flask, jsonify, request
import admin
from db import create_tables


app = Flask(__name__)


@app.route('/Products', methods=["GET"])
def get_products():
    Products = admin.get_all_products()
    return jsonify(Products)


@app.route('/Product/<get_param>', methods=["GET"])
def get_specific_product(get_param):
    Product = admin.get_product(get_param)
    return jsonify(Product)


@app.route('/Product', methods=["PUT"])
def update_product():
    product_details = request.get_json()
    AdminID = product_details["AdminID"]
    AdminName = product_details["AdminName"]
    AdminEmail = product_details["AdminEmail"]
    AdminPhoneNo = product_details["AdminPhoneNo"]
    AdminPassword = product_details["AdminPassword"]
    AdminAddress = product_details["AdminAddress"]
    Product = product_details["Product"]
    ProductCategory = product_details["ProductCategory"]
    ProductPicture = product_details["ProductPicture"]
    ProductPrice = product_details["ProductPrice"]
    result = admin.update(AdminID, AdminName, AdminEmail, AdminPhoneNo,
                          AdminPassword, AdminAddress, Product, ProductCategory, ProductPicture, ProductPrice)
    return jsonify(result)


@app.route("/Product/<AdminID>", methods=["DELETE"])
def delete_specific_product(AdminID):
    result = admin.delete_product(AdminID)
    return jsonify(result)


@app.route("/Product", methods=["POST"])
def insert_product():
    product_details = request.get_json()
    AdminName = product_details["AdminName"]
    AdminEmail = product_details["AdminEmail"]
    AdminPhoneNo = product_details["AdminPhoneNo"]
    AdminPassword = product_details["AdminPassword"]
    AdminAddress = product_details["AdminAddress"]
    Product = product_details["Product"]
    ProductCategory = product_details["ProductCategory"]
    ProductPicture = product_details["ProductPrice"]
    ProductPrice = product_details["ProductPrice"]
    result = admin.insert(AdminName, AdminEmail, AdminPhoneNo,
                          AdminPassword, AdminAddress, Product, ProductCategory, ProductPrice, ProductPrice)
    return jsonify(result)


if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)
