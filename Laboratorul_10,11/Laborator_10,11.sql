CREATE DATABASE TRANZACTII;


CREATE TABLE BancaBRD(
	IdCard INT NOT NULL PRIMARY KEY IDENTITY,
	Nume VARCHAR(255) NOT NULL,
	Prenume VARCHAR(255) NOT NULL,
	SumaBani FLOAT NOT NULL,
	Data_Tranzactie DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE BancaTransilvania(
	IdCard INT NOT NULL PRIMARY KEY IDENTITY,
	Nume VARCHAR(255) NOT NULL,
	Prenume VARCHAR(255) NOT NULL,
	SumaBani FLOAT NOT NULL,
	Data_Tranzactie DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
);


INSERT INTO BancaBRD(Nume,Prenume,SumaBani)
VALUES ('Mihai','Popescu',20000),
	   ('Ion','Vasile',33230),
	   ('Jardan','Matasari',22300),
	   ('Capatina','Petru',20);

INSERT INTO BancaTransilvania(Nume,Prenume,SumaBani)
VALUES ('Rusu','Mihai',200600),
	   ('Capatana','Ion',2700),
	   ('Nicu','Popescu',4000),
	   ('Gigi','Core',50800);

--SELECT * FROM BancaBRD;
--SELECT * FROM BancaTransilvania;
Go
CREATE PROCEDURE TRANSACTION_PROCEDURE @_IdClientCareExecutaTranzactia INT, @_IdClientCarePrimesteTranzactia INT, @_Suma FLOAT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE BancaTransilvania
			SET SumaBani = SumaBani - @_Suma, Data_Tranzactie =  CURRENT_TIMESTAMP
			WHERE IdCard = @_IdClientCareExecutaTranzactia

			UPDATE BancaBRD
			SET SumaBani = SumaBani + @_Suma, Data_Tranzactie =  CURRENT_TIMESTAMP
			WHERE IdCard = @_IdClientCarePrimesteTranzactia
		COMMIT TRANSACTION 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END
GO

-- Am sa execut procedura "TRANSACTION_PROCEDURE" care ne face o tranzactie de la banca Transilvania la banca BRD, am trnasmis ca parametri
-- IdClientCareExecutaTranzactia = 2 si IdClientCarePrimesteTranzactia = 1
-- Capatana Ion(de la banca Transilvania) va face o tranzactie catre Mihai Popescu in suma de 111 Lei.

EXECUTE TRANSACTION_PROCEDURE @_IdClientCareExecutaTranzactia = 2, @_IdClientCarePrimesteTranzactia = 1, @_Suma = 111;


SELECT * FROM BancaBRD;
SELECT * FROM BancaTransilvania;


--un cursor funcțional, împreună cu tabele, relațiile și înregistrările corespunzătoare.


CREATE TABLE PERSOANA(
	IdPersoana INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nume VARCHAR(255) NOT NULL,
	Prenume VARCHAR(255) NOT NULL,
);

CREATE TABLE HOBBY(
	IdHobby INT PRIMARY KEY IDENTITY(1,1),
	Denumire VARCHAR(255) NOT NULL,
);

CREATE TABLE PREFERINTE(
	IdPreferinta INT PRIMARY KEY IDENTITY(1, 1),
	IdPersoana INT FOREIGN KEY REFERENCES PERSOANA(IdPersoana),
	ActivitateIntelectuala INT DEFAULT 0,
	IdHobby INT FOREIGN KEY REFERENCES HOBBY(IdHobby),
);

INSERT INTO PERSOANA(Nume, Prenume)
VALUES ('Mihai', 'Matasari'),
		('Vasile', 'Ion'),
		('Daniel', 'Clau'),
		('Capatana', 'Ceret');

INSERT INTO HOBBY(Denumire)
VALUES ('Cititul'),
		('Privitul filmelor'),
		('Desenatul'),
		('Pescuitul');

INSERT INTO PREFERINTE(IdPersoana,IdHobby)
VALUES 
	(1,2),
	(1,1),
	(2,3),
	(3,3),
	(3,4),
	(1,3),
	(2,1);


--pentru persoanele care au activitatea 'cititul' si 'desenatul' 
--o sa adaugam la 'activitateaIntelectuala' +2, iar la celelalte +1
--si o sa afisam numele prenumele persoanelor si activitatea lor itelecuala.
SET NOCOUNT ON;    

DECLARE cursor_activitate CURSOR FOR
SELECT PERSOANA.Nume, PERSOANA.Prenume, PREFERINTE.IdPreferinta, PREFERINTE.ActivitateIntelectuala, HOBBY.Denumire
FROM HOBBY
INNER JOIN PREFERINTE
ON HOBBY.IdHobby = PREFERINTE.IdHobby
INNER JOIN PERSOANA
ON PERSOANA.IdPersoana = PREFERINTE.IdPersoana;
GO



PRINT 'Nume  Prenume  Activitate Intelectuala'

OPEN cursor_activitate
DECLARE @_Nume VARCHAR(255)
DECLARE @_Prenume VARCHAR(255)
DECLARE @_idPreferinte INT
DECLARE @_Activitate_Intelectuala INT
DECLARE @_Denumire_Hobby VARCHAR(255)
	FETCH NEXT FROM cursor_activitate
	INTO @_Nume, @_Prenume, @_idPreferinte, @_Activitate_Intelectuala, @_Denumire_Hobby
	WHILE @@FETCH_STATUS = 0
		BEGIN
				if(@_Denumire_Hobby = 'Cititul')
					BEGIN
						UPDATE PREFERINTE
						SET PREFERINTE.ActivitateIntelectuala = @_Activitate_Intelectuala + 2
						WHERE PREFERINTE.IdPreferinta = @_idPreferinte;
					END

				if(@_Denumire_Hobby = 'Desenatul')
					BEGIN
						UPDATE PREFERINTE
						SET PREFERINTE.ActivitateIntelectuala = @_Activitate_Intelectuala + 2
						WHERE PREFERINTE.IdPreferinta = @_idPreferinte;
					END
				if(@_Denumire_Hobby = 'Privitul filmelor')
					BEGIN
						UPDATE PREFERINTE
						SET PREFERINTE.ActivitateIntelectuala = @_Activitate_Intelectuala + 1
						WHERE PREFERINTE.IdPreferinta = @_idPreferinte;
					END
				if(@_Denumire_Hobby = 'Pescuitul')
					BEGIN
						UPDATE PREFERINTE
						SET PREFERINTE.ActivitateIntelectuala = @_Activitate_Intelectuala + 1
						WHERE PREFERINTE.IdPreferinta = @_idPreferinte;
					END

			    print ' ' + CAST(@_Nume as varchar(255)) + '  ' + CAST(@_Prenume as varchar(255)) + '  ' + CAST(@_Activitate_Intelectuala as varchar(255));  

			FETCH NEXT FROM cursor_activitate
		INTO @_Nume, @_Prenume, @_idPreferinte, @_Activitate_Intelectuala, @_Denumire_Hobby
		END
CLOSE cursor_activitate;


DEALLOCATE cursor_activitate;

