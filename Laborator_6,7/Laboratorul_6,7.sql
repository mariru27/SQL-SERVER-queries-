
--se va hace inner join intre tabela STUDENT si CATALOG si se va afisa (S.Nume,S.Prenume,C.cod_disciplina,C.Nota), 
--unde C.Cod_disciplina trebuie sa fie mai mare ca 5
--1)EXEMPLU INNER JOIN
SELECT S.Nume,S.Prenume,C.cod_disciplina,C.Nota
FROM CATALOG_DB.dbo.STUDENT S 
INNER JOIN CATALOG_DB.dbo.CATALOG C
ON S.NrLeg=C.NrLeg
WHERE C.Cod_disciplina > 5

--2)EXEMPLU OUTER JOIN, care se imparte in 3 categorii:LEFT JOIN, RIGHT JOIN, FULL JOIN

--a)LEFT OUTER JOIN(OR LEFT JOIN)
SELECT S.NrLeg, Nume, Prenume, Nota
FROM CATALOG_DB.dbo.STUDENT S 
LEFT OUTER JOIN CATALOG_DB.dbo.CATALOG C
ON S.Nrleg=C.NrLeg

--b)RIGHT OUTER JOIN(OR RIGHT JOIN)
SELECT S.NrLeg, Nume, Prenume, Nota
FROM CATALOG_DB.dbo.STUDENT S 
RIGHT OUTER JOIN CATALOG_DB.dbo.CATALOG C
ON S.Nrleg=C.NrLeg

--c)FULL OUTER JOIN(OR FULL JOIN)
SELECT S.NrLeg, Nume, Prenume, Nota
FROM CATALOG_DB.dbo.STUDENT S 
FULL OUTER JOIN CATALOG_DB.dbo.CATALOG C
ON S.Nrleg=C.NrLeg


--crearea unei vederi cu notele mari decat 5 ale studentilor al caror nume se termina in 'escu'.
CREATE VIEW ExempluVedere
AS
SELECT S.Nume,S.Prenume,C.Nota
FROM CATALOG_DB.dbo.CATALOG AS C
INNER JOIN CATALOG_DB.dbo.STUDENT AS S
ON S.NrLeg = C.NrLeg
WHERE (C.Nota > 5) AND (S.Nume like '%escu')



SELECT * FROM ExempluVedere;