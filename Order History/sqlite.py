import sqlite3
from OrderID import OrderID

conn = sqlite3.connect('orderID.db')

c = conn.cursor()

#c.execute("""CREATE TABLE orderID (
#            customerid Integer,
#            adminid Integer,
#            productforsale text,
#            productcategory text,
#            dateofsale Integer,
#            picture text,
#            numberofitems Integer,
#            itemsprice Integer,
#            totalcost Integer,
#            )""")

#c.execute(" INSERT INTO OrderID VALUES ('123', '246', 'iphone', 'phones', '01/01/2021', 'picture', '2', '6000', '12000', )")

c.execute("SELECT * FROM OrderID WHERE customerid=?", ('123',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE adminid=?", ('246',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE productforsale=?", ('iphone',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE productcategory=?", ('phone',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE dateofsale=?", ('01/01/2021',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE picture=?", ('picture',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE numberofitems=?", ('2',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE itemsprice=?", ('6000',))
print(c.fetchall())

c.execute("SELECT * FROM OrderID WHERE totalcost=?", ('12000',))
print(c.fetchall())

conn.commit()

conn.close()
