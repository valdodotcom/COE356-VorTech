import sqlite3
from sqlite3.dbapi2 import connect

class Database:
    def __init__(self):
        conn = sqlite3.connect("E-commerce.db")
        cursor = conn.cursor()
        cursor.execute("CREATE TABLE IF NOT EXISTS table_wishlist(customer_id INTEGER, Product_for_sale TEXT, Product_Category TEXT, Picture_of_Product VARBINARY(8000), Admin_id INTEGER, PRIMARY KEY(customer_id), FOREIGN KEY(Admin_id) REFERENCES Admin_table(Admin_id))")
        conn.commit()
        conn.close()




    def insert_data(self, product_for_sale, product_category, picture_of_product, admin_id):
        self.conn = sqlite3.connect("E-commerce.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("INSERT INTO table_wishlist VALUES (NULL, ?, ?, ?, ?)", (product_for_sale, product_category, picture_of_product, admin_id))
        self.conn.commit()
        self.conn.close()


    def update_data(self, product_for_sale, product_category, picture_of_product, admin_id, customer_id):
        self.conn = sqlite3.connect("E-commerce.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("UPDATE table_wishlist SET product_for_sale=?, product_category=?, picture_of_product=?, admin_id=? WHERE customer_id=?", (product_for_sale, product_category, picture_of_product, admin_id, customer_id))
        self.conn.commit()
        self.conn.close()

    def delete_data(self, customer_id):
        self.conn = sqlite3.connect("E-commerce.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("DELETE FROM table_wishlist WHERE customer_id=?", (customer_id,))
        self.conn.commit()
        self.conn.close()

    def query_all_data(self):
        self.conn = sqlite3.connect("E-commerce.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("SELECT * FROM table_wishlist")
        self.rows = self.cursor.fetchall()
        self.conn.close()
        return self.rows


    def query_any_data(self, product_for_sale="", product_category="", picture_of_product="", admin_id=""):
        self.conn = sqlite3.connect("E-commerce.db")
        self.cursor = self.conn.cursor()
        self.cursor.execute("SELECT * FROM table_wishlist WHERE product_for_sale=? or product_category=? or picture_of_product=? or admin_id=? ", (product_for_sale, product_category, picture_of_product, admin_id))
        self.rows = self.cursor.fetchall()
        self.conn.close()
        return self.rows



shirt='C:/Users/Asihene/Desktop/WishList Database/shirt.jpg'
shoes='C:/Users/Asihene/Desktop/WishList Database/pair-trainers.jpg'


database= Database()
database.insert_data(product_for_sale='shoes', product_category='Men and Women', picture_of_product=shoes, admin_id=23698)

# # database.delete_data(7)
# # database.update_data(product_for_sale='shirt', product_category='Men', picture_of_product=shirt, admin_id=23698, customer_id=2)
for record in database.query_all_data():
 print(record)
# # query_any_data
 # # print(database.query_any_data('shirt'))
 # # print(database.query_any_data('', 'Men'))