--1.Creaci�n base de datos
use master;
go
create database DWFESSIT;

--Creaci�n de tablas con llaves primarias
use DWFESSIT;

create table HTICKETS(
id int IDENTITY(1,1) primary key not null,
titulo varchar (50),
descripcion varchar (250),
--foraneas
idusuario int,
idsolicitud int UNIQUE,
idtiempo varchar(200),
idpqrs int,
iddocumento int,
idcategoria int,
idedepartamento int,
idtecnico int
)


create table dimensionusuario(
id int primary key not null,
nombre varchar(150),
correo varchar(150),
usuario varchar(150),
--foraneas
iddocumentou int
)

create table dimdocumento(
id int primary key not null,
tipo char(3),
documento varchar(150),
--foraneas
idfuncion int
)

create table dimfuncion(
id int primary key not null,
tipo varchar(30),
descripcion varchar(150),
--foraneas
idpermiso int
)

create table dimpermiso(
id int primary key not null,
tipo varchar(30),
descripcion varchar(150),
)

create table dimensionpqrs(
id int primary key not null,
titulo varchar(50),
descripcion varchar(250),
--foraneas
idclasif int
)

create table dimclasif(
id int primary key not null,
titulo varchar(50),
descripcion varchar(250),
)


create table dimensidocumento(
id int primary key not null,
titulo varchar(50),
descripcion varchar(250),
peso int,
--foraneas
idruta int
)

create table dimruta(
id int primary key not null,
disco char(2),
segano varchar(50),
segmes varchar(50),
segnombrrecurso varchar(250)
)

create table dimensiontecnico(
id int primary key not null,
estado varchar(10),
cargo varchar(100),
ESP varchar(50),
--foraneas
iddocumento int
)

create table dimdocumentotec(
id int primary key not null,
tipo char(3),
documento varchar(150)
)

create table dimensioncategoria(
id int primary key not null,
titulo varchar(100),
descripcion varchar(240)
)

create table dimensionsolicitud(
id int primary key not null,
estado varchar(15),
tiempotranscurridoS  int,
tiempotranscurridoNS  int,
tiempotranscurridoIN  int,
tiempotranscurridoRE  int
)

create table dimensiondepartamento(
id int primary key not null,
titulo varchar(100),
descripcion varchar(250),
ubicacion varchar(20),
personal int
)

create table dimensiontiempo(
id int primary key not null,
diasemana varchar(10),
mes varchar(10),
ano int,
fecha date,
hora int
)

create table auditoriadw(
fecha date,
usuario VARCHAR(200),
accion VARCHAR(15),
tabla VARCHAR(50)

)



--Creac�n llaves foraneas.


use DWFESSIT;

ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idusuario
FOREIGN KEY (idusuario) REFERENCES dimensionusuario(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idsolicitud
FOREIGN KEY (idsolicitud) REFERENCES dimensionsolicitud(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idtiempo
FOREIGN KEY (idtiempo) REFERENCES dimensiontiempo(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idpqrs
FOREIGN KEY (idpqrs) REFERENCES dimensionpqrs(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_iddocumento
FOREIGN KEY (iddocumento) REFERENCES dimensidocumento(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idcategoria
FOREIGN KEY (idcategoria) REFERENCES dimensioncategoria(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idedepartamento
FOREIGN KEY (idedepartamento) REFERENCES dimensiondepartamento(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE HTICKETS
ADD CONSTRAINT FK_idtecnico
FOREIGN KEY (idtecnico) REFERENCES dimensiontecnico(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimensionusuario
ADD CONSTRAINT FK_iddocuusu
FOREIGN KEY (iddocumentou) REFERENCES dimdocumento(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimdocumento
ADD CONSTRAINT FK_idfuncion
FOREIGN KEY (idfuncion) REFERENCES dimfuncion(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimfuncion
ADD CONSTRAINT FK_idpermiso
FOREIGN KEY (idpermiso) REFERENCES dimpermiso(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimensionpqrs
ADD CONSTRAINT FK_idclasif
FOREIGN KEY (idclasif) REFERENCES dimclasif(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimensidocumento
ADD CONSTRAINT FK_idruta
FOREIGN KEY (idruta) REFERENCES dimruta(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;
ALTER TABLE dimensiontecnico
ADD CONSTRAINT FK_iddocumentotec
FOREIGN KEY (iddocumento) REFERENCES dimdocumentotec(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;

--Triggers
--1
go
CREATE TRIGGER tr_htickets
ON HTICKETS AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'HTICKETS'
FROM INSERTED
END;
--2
go
CREATE TRIGGER tr_dimension
ON dimensidocumento AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensidocumento'
FROM INSERTED
END;
--3
go
CREATE TRIGGER tr_dimensioncategoria
ON dimensioncategoria AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensioncategoria'
FROM INSERTED
END;
--4
go
CREATE TRIGGER tr_dimensiondepartamento
ON dimensiondepartamento AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensiondepartamento'
FROM INSERTED
END;
--5
go
CREATE TRIGGER tr_dimensionpqrs
ON dimensionpqrs AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensionpqrs'
FROM INSERTED
END;
--6
go
CREATE TRIGGER tr_dimensionsolicitud
ON dimensionsolicitud AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensionsolicitud'
FROM INSERTED
END;
--7
go
CREATE TRIGGER tr_dimensiontecnico
ON dimensiontecnico AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensiontecnico'
FROM INSERTED
END;
--8
go
CREATE TRIGGER tr_dimensiontiempo
ON dimensiontiempo AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensiontiempo'
FROM INSERTED
END;
--9
go
CREATE TRIGGER tr_dimensionusuario
ON dimensionusuario AFTER INSERT AS BEGIN
SET NOCOUNT ON;
INSERT INTO auditoriadw
(fecha, usuario, accion, tabla)
SELECT GETUTCDATE(), CURRENT_USER,'Agrego', 'dimensionusuario'
FROM INSERTED
END;


--USUARIOS DE PRUEBA
SELECT * FROM dimensionusuario
INSERT INTO dimensionusuario(id,nombre,correo,usuario) VALUES (
1,	'Administrador',	'androb.proj.1010@gmail.com','1'),
(4,	'fabian.lopez',	'fabiandreslopez91@gmail.com',	2),
(5,	'andres.roa',	'anrob.1010@gmail.com',	2),
(6,	'carlos.alfonso',	'alfonso16-08@hotmail.com',	3),
(7,	'yeison.castro',	'castroyeison17@hotmail.com',	3),
(8,	'ernesto.vargas',	'ernestovargas3010@gmail.com',	3),
(3,	'jaime.valencia',	'jaimevalencia@napsdeveloper.com',	1),
(2,	'desarrollo',	'androb.proj.1010@gmail.com',	2)

INSERT INTO dimensiontiempo(id)VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)

INSERT INTO dimensionpqrs(id)VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)

INSERT INTO dimensidocumento(id) VALUES
(1),(2),(3)

INSERT INTO dimensiondepartamento(id) VALUES
(1),(2),(3)

INSERT INTO dimensiontecnico(id) VALUES
(1),(2),(3)

INSERT INTO dimensioncategoria (id, titulo, descripcion) VALUES
(1,	'Fallo de Red',	'Lentitud o caida de la red'),
(2,	'Daño de perifericos',	'Falla de Teclado, mouse, pantalla, impresora, Diadema'),
(3,	'Daño de computador',	'Falla del computador asignado'),
(4,	'Falla de software',	'Falla de algún software instalado en el equipo'),
(5,	'Creación de usuario',	'Solicitud para crear un usuario nuevo en las aplicaciones de la cmpañia'),
(6,	'Asignación de equipo',	'Solicitud para la instalación de un nuevo equipo'),
(7,	'Instalación de software',	'solicitud para la instalación o reinstalación de un software'),
(8,	'Petición',null),
(9,	'Queja',null),
(10,	'Reclamo',null),
(11, 'Solicitud',null)

--Diccionario de datos de Sql server.
use DWFESSIT;
select 
	d.object_id,
	a.name [table], 
	b.name [column], 
	c.name [type], 
	CASE
	 
		WHEN c.name = 'numeric' OR  c.name = 'decimal' OR c.name = 'float'  THEN b.precision
		ELSE null
	END [Precision], 

	b.max_length, 
	CASE
		WHEN b.is_nullable = 0 THEN 'NO'
		ELSE 'SI'
	END [Permite Nulls],
	CASE 
		WHEN b.is_identity = 0 THEN 'NO'
		ELSE 'SI'
	END [Es Autonumerico],	
	ep.value [Descripcion],
	f.ForeignKey, 
	f.ReferenceTableName,
	f.ReferenceColumnName 
from sys.tables a   
  
	inner join sys.columns b on a.object_id= b.object_id 
	inner join sys.systypes c on b.system_type_id= c.xtype 
	inner join sys.objects d on a.object_id= d.object_id 
	LEFT JOIN sys.extended_properties ep ON d.object_id = ep.major_id AND b.column_Id = ep.minor_id
	LEFT JOIN (SELECT 
				f.name AS ForeignKey,
				OBJECT_NAME(f.parent_object_id) AS TableName,
				COL_NAME(fc.parent_object_id,fc.parent_column_id) AS ColumnName,
				OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,
				COL_NAME(fc.referenced_object_id,fc.referenced_column_id) AS ReferenceColumnName
				FROM sys.foreign_keys AS f
				INNER JOIN sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id) 	f ON f.TableName =a.name AND f.ColumnName =b.name
WHERE a.name <> 'sysdiagrams' 
ORDER BY a.name,b.column_Id

