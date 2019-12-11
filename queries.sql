-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select ProductName, CategoryName 
from Product 
join Category 
    on Product.CategoryId = Category.Id

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
select ID, ShipName from [Order]
where [Order].OrderDate < '2012-08-09'

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
select ProductName, Quantity 
from OrderDetail 
join Product 
    on OrderDetail.ProductId = Product.Id
where OrderID = 10251
order by ProductName

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select [Order].Id as OrderID, 
    CompanyName, 
    Employee.LastName as EmployeeLastName 
from [Order]
join Customer 
    on [Order].CustomerId = Customer.Id
join Employee 
on [Order].EmployeeId = Employee.Id;

--Stretch: Displays CategoryName and a new column called Count that shows how many products are in each category. Shows 9 records.

SELECT [Categories].CategoryName, Count(ProductID) as Count
FROM [Categories] join Products on [Categories].CategoryID = [Products].CategoryID
GROUP BY [Categories].CategoryName

--Stretch: Display OrderID and a column called ItemCount that shows the total number of products placed on the order. Shows 196 records.

SELECT [Orders].OrderID, SUM([OrderDetails].Quantity) as ItemCount
FROM [Orders] join [OrderDetails] on [Orders].OrderID = [OrderDetails].OrderID
GROUP BY [Orders].OrderID
