/*1. List all suppliers in the UK */

SELECT *
FROM Masteryhive.dbo.Supplier;

SELECT *
FROM dbo.Supplier;

/*2.  List the first name, last name, and city for all customers. Concatenate the first and last name
separated by a space and a comma as a single column */

SELECT concat(firstname, ' ', lastname) AS FullName, City 
FROM dbo.Customer;

/*3 List all customers in Sweden */

SELECT * 
FROM dbo.Customer
WHERE Country = 'Sweden';

/*4 List all suppliers in alphabetical order*/

SELECT *
FROM dbo.Supplier
ORDER BY CompanyName ASC;

SELECT *
FROM dbo.Supplier
ORDER BY ContactName ASC;

/*5 List all suppliers with their products*/

SELECT  s.Id, p.ProductName, s.companyName, s.ContactName, concat(city, ', ', country) AS City_Country, s.phone
FROM dbo.Supplier s
JOIN dbo.Product p on p.Id = s.Id;


/*6. List all orders with customers information*/

SELECT  o.OrderDate, o.OrderNumber,  concat(firstname, ' ', lastname) AS FullName, 
concat(city, ', ', country) AS City_Country, c.Phone
FROM dbo.[Order] o
JOIN dbo.Customer c on o.Id = c.Id;

SELECT 
  C.Id,
  O.OrderNumber,
  CONCAT(c.FirstName,',', ' ',c.LastName) as OrderedBy,
  City, 
  Country,
  Phone
From Masteryhive.dbo.Customer c
JOIN Masteryhive.dbo.[Order] o ON c.Id = o.Id;


/*7. List all orders with product name, quantity, and price, sorted by order number */

SELECT  o.OrderNumber, p.ProductName,  oi.Quantity, p.UnitPrice, (quantity * p.UnitPrice) AS TotalPrice
FROM dbo.Product p
INNER JOIN dbo.OrderItem oi on oi.Id = p.Id
INNER JOIN dbo.[Order] o on oi.Id = o.Id
ORDER BY OrderNumber;


/*8. Using a case statement, list all the availability of products. When 0 then not available, else
available */

SELECT ProductName AS Product,
		CASE IsDiscontinued 
		WHEN 0 THEN 'NOT AVAILABLE' 
		ELSE 'AVAILABLE'
	END 'AVAILABILITY'
FROM dbo.Product;

/*9. Using case statement, list all the suppliers and the language they speak. The language they
speak should be their country E.g if UK, then English */

SELECT CompanyName AS Supplier, Country,
CASE Country
WHEN 'Australia' THEN 'English'
         WHEN 'Brazil' THEN 'Portuguese'
		 WHEN 'Canada' THEN 'English'
		 WHEN 'Denmark' THEN 'Danish, English'
		 WHEN 'Finland' THEN  'Finnish, Swedish'
		 WHEN 'France' THEN 'French' 
		 WHEN 'Germany' THEN 'German'
		 WHEN 'Italy'  THEN 'Italian'
		 WHEN 'Japan' THEN 'Japanese'
		 WHEN 'Netherlands' THEN 'Dutch'
		 WHEN 'Norway' THEN 'Norwegain, Sami'
		 WHEN 'Singapore' THEN 'Malay, Mandarin, Tamil, English'
		 WHEN 'Spain' THEN 'Spanish'
		 WHEN 'Sweden' THEN 'Swedish'
		 WHEN 'UK' THEN 'English'
		 WHEN 'USA' THEN 'English'
	END 'LANGUAGE'
FROM dbo.Supplier;


/*10. List all products that are packaged in Jars*/

SELECT ProductName, ID AS ProductID, Package 
FROM dbo.Product
WHERE lower(Package) LIKE '%Jars%';


/*11 List procucts name, unitprice and packages for products that starts with Ca*/

SELECT ProductName, Unitprice, Package 
FROM dbo.Product
WHERE lower(ProductName) LIKE 'Ca%';

/*12. List the number of products for each supplier, sorted high to low.*/

SELECT  s.CompanyName, s.Id,COUNT(P.SupplierId) AS Number_Of_Products
FROM dbo.Supplier AS S
INNER JOIN dbo.Product AS P ON (S.Id = P.SupplierId)
GROUP BY S.CompanyName, S.Id
ORDER BY COUNT(P.SupplierId) DESC;

/* 13. List the number of customers in each country.*/

SELECT C.Country, COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
GROUP BY C.Country;


/*14 List the number of customers in each country, sorted high to low.*/

SELECT C.Country, COUNT(C.Id) AS Number_Of_Customers
FROM dbo.Customer AS C
GROUP BY C.Country
ORDER BY COUNT(C.Id) desc;


/*15. List the total order amount for each customer, sorted high to low.*/

SELECT C.Id, CONCAT(C.FirstName,' ,',C.LastName) AS Customer_FullName,
	SUM(O.TotalAmount) Total_amount_per_customer
FROM dbo.Customer C
LEFT JOIN [dbo].[Order] O ON (C.Id = O.CustomerId)
GROUP BY C.Id,CONCAT(C.FirstName,' ,',C.LastName)
ORDER BY SUM(O.TotalAmount) DESC;


/*16. List all countries with more than 2 suppliers.*/

SELECT S.Country, COUNT(S.Id) AS Number_Of_Suppliers
FROM dbo.Supplier AS S
GROUP BY S.Country
HAVING COUNT(S.Id) > 2
ORDER BY COUNT(S.Id) DESC;


/*17.17. List the number of customers in each country. Only include countries with more than 10
customers.*/

SELECT Country, COUNT(c.Id) AS Number_of_Customers 
FROM dbo.Customer c
GROUP BY C.Country
HAVING COUNT(C.Id) > 10
ORDER BY COUNT(C.Id) DESC;


/*18. List the number of customers in each country, except the USA, sorted high to low. Only
include countries with 9 or more customers.*/

SELECT Country, COUNT(c.Id) AS Number_of_Country
FROM dbo.Customer c
WHERE c.Country <>  'USA'
GROUP BY c.Country
HAVING COUNT(C.Id) > 9
ORDER BY COUNT(C.Id) DESC;


/*19.List customer with average orders between $1000 and $1200.*/

SELECT  CONCAT(C.FirstName,' ,',C.LastName) AS Customer_FullName,	
	AVG(O.TotalAmount) Total_amount_per_customer, C.Id
FROM dbo.Customer C
LEFT JOIN [dbo].[Order] O ON (C.Id = O.CustomerId)
GROUP BY CONCAT(C.FirstName,' ,', C.LastName), C.Id
HAVING (AVG(O.TotalAmount) BETWEEN 1000 AND 1200)
ORDER BY AVG(O.TotalAmount) DESC;


/*20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.*/

SELECT	CONCAT(MONTH(OrderDate),'-',YEAR(OrderDate)) AS Month_and_Year,
	COUNT(OrderDate) AS Total_number_of_orders,
	SUM(TotalAmount) AS Total_Amount_Sold
FROM [dbo].[Order]
WHERE (YEAR(OrderDate) = '2013' AND MONTH(OrderDate) = '1')
GROUP BY CONCAT(MONTH(OrderDate),'-',YEAR(OrderDate));