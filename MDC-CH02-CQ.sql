-- TABLES
-- +--------------------+
-- | Tables_in_mdc_ch02 |
-- +--------------------+
-- | CUSTOMER           |
-- | INVOICE            |
-- | INVOICE_ITEM       |
-- +--------------------+
--
-- CUSTOMER TABLE
-- +------------+-----------+-----------+--------------+--------------------------------+------------+
-- | CustomerID | FirstName | LastName  | Phone        | EmailAddress                   | ReferredBy |
-- +------------+-----------+-----------+--------------+--------------------------------+------------+


-- INVOICE TABLE
-- +---------------+------------+------------+------------+-------------+
-- | InvoiceNumber | CustomerID | DateIn     | DateOut    | TotalAmount |
-- +---------------+------------+------------+------------+-------------+

-- INVOICE_ITEM TABLE
-- +---------------+------------+---------------+----------+-----------+
-- | InvoiceNumber | ItemNumber | Item          | Quantity | UnitPrice |
-- +---------------+------------+---------------+----------+-----------+


-- B 
select * from CUSTOMER;
select * from INVOICE;
select * from INVOICE_ITEM;

-- C 
SELECT LastName, FirstName, Phone from CUSTOMER;

-- D 
SELECT LastName, FirstName, Phone from CUSTOMER WHERE FirstName = "Nikki";

-- E 
SELECT LastName, FirstName, Phone, DateIn, DateOut from INVOICE WHERE FirstName = "Nikki";

-- F
SELECT LastName, FirstName, Phone, DateIn, DateOut
from CUSTOMER c
INNER JOIN INVOICE i
ON c.CustomerID = i.CustomerID
WHERE i.TotalAmount > 100;

-- G
SELECT LastName, FirstName, Phone 
FROM CUSTOMER 
WHERE FirstName LIKE 'B%';

-- H
SELECT LastName, FirstName, Phone 
FROM CUSTOMER 
WHERE LastName LIKE '%cat%';

-- I
SELECT LastName, FirstName, Phone 
FROM CUSTOMER 
WHERE Phone LIKE '2%3%';

-- J
SELECT MAX(TotalAmount) AS MaxTotal, MIN(TotalAmount) AS MinTotal 
FROM INVOICE;

-- K
SELECT AVG(TotalAmount) AS AverageTotal 
FROM INVOICE;

-- L
SELECT COUNT(*) AS CustomerCount 
FROM CUSTOMER;

-- M
SELECT LastName, FirstName 
FROM CUSTOMER 
GROUP BY LastName, FirstName;

-- N
SELECT LastName, FirstName, COUNT(*) AS Count 
FROM CUSTOMER 
GROUP BY LastName, FirstName;

-- O
SELECT LastName, FirstName, Phone 
FROM CUSTOMER 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM INVOICE 
    WHERE TotalAmount > 100
)
ORDER BY LastName ASC, FirstName DESC;

-- P
SELECT C.LastName, C.FirstName, C.Phone 
FROM CUSTOMER C, INVOICE I 
WHERE C.CustomerID = I.CustomerID AND I.TotalAmount > 100 
ORDER BY C.LastName ASC, C.FirstName DESC;

-- Q
SELECT C.LastName, C.FirstName, C.Phone 
FROM CUSTOMER C 
JOIN INVOICE I ON C.CustomerID = I.CustomerID 
WHERE I.TotalAmount > 100 
ORDER BY C.LastName ASC, C.FirstName DESC;

-- R
SELECT LastName, FirstName, Phone 
FROM CUSTOMER 
WHERE CustomerID IN (
    SELECT I.CustomerID 
    FROM INVOICE_ITEM I 
    WHERE I.Item = 'Dress Shirt'
)
ORDER BY LastName ASC, FirstName DESC;

-- S
SELECT C.LastName, C.FirstName, C.Phone 
FROM CUSTOMER C, INVOICE I, INVOICE_ITEM II 
WHERE C.CustomerID = I.CustomerID AND I.InvoiceNumber = II.InvoiceNumber AND II.Item = 'Dress Shirt' 
ORDER BY C.LastName ASC, C.FirstName DESC;

SELECT C.LastName AS CustomerLastName, C.FirstName AS CustomerFirstName, 
       R.LastName AS ReferredByLastName, R.FirstName AS ReferredByFirstName 
FROM CUSTOMER C 
LEFT JOIN CUSTOMER R ON C.ReferredBy = R.CustomerID;

-- T
SELECT C.LastName, C.FirstName, C.Phone 
FROM CUSTOMER C 
JOIN INVOICE I ON C.CustomerID = I.CustomerID 
WHERE I.InvoiceNumber IN (
    SELECT InvoiceNumber 
    FROM INVOICE_ITEM 
    WHERE Item = 'Dress Shirt'
)
ORDER BY C.LastName ASC, C.FirstName DESC;

-- U
SELECT C.LastName, C.FirstName, C.Phone, I.TotalAmount 
FROM CUSTOMER C 
JOIN INVOICE I ON C.CustomerID = I.CustomerID 
WHERE I.InvoiceNumber IN (
    SELECT InvoiceNumber 
    FROM INVOICE_ITEM 
    WHERE Item = 'Dress Shirt'
)
UNION 
SELECT C.LastName, C.FirstName, C.Phone, NULL AS TotalAmount 
FROM CUSTOMER C 
WHERE C.CustomerID NOT IN (
    SELECT CustomerID 
    FROM INVOICE I 
    JOIN INVOICE_ITEM II ON I.InvoiceNumber = II.InvoiceNumber 
    WHERE II.Item = 'Dress Shirt'
)
ORDER BY TotalAmount ASC, LastName ASC, FirstName DESC;

