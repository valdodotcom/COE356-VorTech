class OrderID

         def __init__(self, customerid, adminid, productforsale, productcategory, dateofsale, picture, numberofitems, itemsprice,
         totalcost):
         self.customerid = customerid
         self.adminid = adminid
         self.productforsale = productforsale
         self.productcategory = productcategory
         self.dateofsale = dateofsale
         self.picture = picture
         self.numberofitems = numberofitems
         self.itemsprice = itemsprice
         self.totalcost = totalcost

         @property
         def __repr__(self):
             return "OrderID('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', {})".format(self.customerid, self.adminid, self.productforsale,
             self.productcategory, self.dateofsale, self.picture, self.numberofitems, self.itemsprice, self.totalcost)
