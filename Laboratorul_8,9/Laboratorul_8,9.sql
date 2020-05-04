

CREATE PROCEDURE Nume_Nota @_nume VARCHAR(255)
AS 
RETURN(SELECT COUNT(S.Nume) FROM CATALOG_DB.dbo.STUDENT AS S WHERE S.Nume = @_nume)
GO

DECLARE @numar INT
EXECUTE @numar = Nume_Nota @_nume = 'Mihai';
PRINT @numar;
GO

use CATALOG_DB
go

--DROP TRIGGER dbo.ANNOUNCE_AFTER_UPDATE;

CREATE TRIGGER ANNOUNCE_AFTER_UPDATE
ON dbo.STUDENT 
FOR UPDATE
AS
BEGIN 
DECLARE @_nume VARCHAR(255)
SELECT @_nume = I.Nume
FROM inserted I, STUDENT S
WHERE S.NrLeg = I.NrLeg
IF UPDATE(Nume)
	RAISERROR('S-a modificat campul nume ai tabelei STUDENT',16,1)
ELSE
	RAISERROR('S-a modificat alt camp al tabelei STUDENT',16,1);
END
GO

UPDATE CATALOG_DB.dbo.STUDENT
SET Nume = 'Popescu'
WHERE NrLeg=5;


