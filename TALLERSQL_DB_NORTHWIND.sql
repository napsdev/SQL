--Taller procedimientos almacenados
USE Northwind;
--1.Realizar un procedimiento almacenado que devuelva los clientes (Customers) según
el país (Country).
GO
CREATE PROCEDURE
ClxPais
@Country varchar(40) AS SELECT
* FROM Customers c WHERE c.Country=@Country
EXECUTE ClxPais Mexico

--2.Crear un procedimiento que determine la cantidad de clientes cuyo identificador (o sea
el código) inicia con un determinado carácter.
GO
CREATE PROCEDURE
CLxID
@id_c varchar(40) AS SELECT
* FROM Customers c WHERE c.CustomerID=@id_c
EXECUTE CLxID ALFKI

--3.Realizar un procedimiento que determine la cantidad de registros que un cliente está en
la tabla ORDERS.
GO
CREATE PROCEDURE
CLxOrder AS SELECT
c.ContactName, count(o.OrderID)
AS Cantidad_Registros
FROM Orders o, Customers c
WHERE c.CustomerID=o.CustomerID GROUP BY c.ContactName
EXECUTE CLxOrder

--5.Realizar un procedimiento que seleccione todos los registros de tabla Productos y
Categorías a la vez.
GO
CREATE PROCEDURE
PRxCate @Categoria Varchar(40) AS SELECT
* FROM Products p, Categories c
WHERE p.CategoryID=c.CategoryID
AND c.CategoryID=@Categoria
EXECUTE PRxCate 1

--6.Realizar un procedimiento que seleccione todos los productos que no corresponde a la
categoría bebidas (1).
GO
CREATE PROCEDURE
PRnotBeb AS SELECT
* FROM Products p , Categories c WHERE
c.CategoryID=p.CategoryID AND c.CategoryID !=1
EXECUTE PRnotBeb

--7.Realizar un procedimiento que obtenga la cantidad de registros que no corresponde a
condimentos.
GO
CREATE PROCEDURE
PRnotCond AS SELECT
COUNT(*) AS totalp FROM Products p,
Categories c WHERE
c.CategoryID=p.CategoryID AND c.CategoryID!=2
EXECUTE PRnotCond

--8.Realizar un procedimiento que seleccione todos los campos de los registros que no
corresponden a categoría mariscos de la tabla productos.
GO
CREATE PROCEDURE
PRnotMaris AS SELECT
* FROM Products p, Categories c
WHERE c.CategoryID=p.CategoryID
AND c.CategoryID!=8
EXECUTE PRnotMaris

--9.Realizar un procedimiento que seleccione los campos nombre del producto y precio
(únicamente) de los productos diferentes a cárnicos.
GO
CREATE PROCEDURE
PRpreciNotCarn AS SELECT
p.ProductName, p.UnitPrice
FROM Products p WHERE p.CategoryID !=(6)
EXECUTE PRpreciNotCarn

--10.Realizar un procedimiento que obtenga la cantidad de productos granos y cereales.
GO
CREATE PROCEDURE
PRxGanCer AS SELECT
count(p.CategoryID) as Cantidad FROM Products p
WHERE p.CategoryID=5
EXECUTE PRxGanCer

--11.Realizar un procedimiento que seleccione los campos nombre del producto y
precio (únicamente) de los quesos y productos cárnicos.
GO
CREATE PROCEDURE
PRxQueCarPre AS SELECT
p.ProductName, p.UnitPrice
FROM Products p WHERE p.CategoryID IN (4,6)
EXECUTE PRxQueCarPre

--12.Realizar un procedimiento que seleccione los campos nombre del producto, precio
y stock (únicamente) de las frutas secas y mariscos.
GO
CREATE PROCEDURE
PRFruSecMaris AS SELECT
p.ProductName, p.UnitPrice, p.UnitsInStock
FROM Products p WHERE p.CategoryID IN (7,8)
EXECUTE PRFruSecMaris

--13.Realizar un procedimiento que seleccione el promedio de los precios de los confites.
GO
CREATE PROCEDURE PRConfiPro AS SELECT
AVG(p.UnitPrice) AS total_dulces FROM Products p
WHERE p.CategoryID = 3
EXECUTE PRConfiPro

