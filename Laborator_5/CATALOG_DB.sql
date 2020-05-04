USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'INTREPRINDERE'
)
CREATE DATABASE [CATALOG_DB]
GO
--DROP TABLE CATALOG_DB.dbo.CATALOG
--DROP TABLE CATALOG_DB.dbo.STUDENT;
--DELETE TOP(20) CATALOG_DB.dbo.STUDENT;

CREATE TABLE CATALOG_DB.dbo.CATALOG(
	NrLeg INT FOREIGN KEY REFERENCES CATALOG_DB.dbo.STUDENT(NrLeg),
	Cod_disciplina INT FOREIGN KEY REFERENCES CATALOG_DB.dbo.DISCIPLINA(Cod_disciplina),
	Nota INT
)

CREATE TABLE CATALOG_DB.dbo.STUDENT(
	NrLeg INT PRIMARY KEY IDENTITY(1,1),
	Nume VARCHAR(255),
	Prenume VARCHAR(255),
	Grupa INT
)


CREATE TABLE CATALOG_DB.dbo.DISCIPLINA(
	Cod_disciplina INT PRIMARY KEY IDENTITY(1,1),
	Disciplina VARCHAR(255)
)

INSERT INTO CATALOG_DB.dbo.STUDENT(Nume,Prenume,Grupa)
VALUES 
	('Mihai','Mihaescu',222),
	('Adrei','Vasilescu',122),
	('Ion','Grigorescu',122),
	('Maria','Ioana',222),
	('Gigel','Popescu',222),
	('Angrei','Bobo',122);

--SELECT * FROM CATALOG_DB.dbo.STUDENT;

--UPDATE CATALOG_DB.dbo.STUDENT
--SET Nume = 'Popescu', Prenume='Mihai'
--WHERE NrLeg=5;

INSERT INTO CATALOG_DB.dbo.DISCIPLINA(Disciplina)
VALUES ('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina'),
	('Disciplina');

INSERT INTO  CATALOG_DB.dbo.CATALOG(NrLeg,Cod_disciplina,Nota)
VALUES (1,9,10),
	(1,2,10),
	(1,3,8),
	(2,1,10),
	(2,2,6),
	(2,3,5),
	(3,1,10),
	(3,2,9),
	(4,3,8),
	(4,1,10),
	(5,2,10),
	(5,3,8),
	(6,1,10),
	(6,2,6),
	(1,5,8),
	(2,4,10),
	(2,5,10),
	(2,7,8),
	(3,4,10),
	(4,5,10),
	(4,6,8),
	(1,5,10),
	(1,9,10);


