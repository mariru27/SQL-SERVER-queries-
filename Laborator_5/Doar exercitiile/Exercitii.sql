
SELECT *
FROM CATALOG_DB.dbo.Catalog
WHERE NrLeg=(SELECT NrLeg
FROM CATALOG_DB.dbo.Student
WHERE Nume = 'Popescu' AND Grupa='222')

SELECT *
FROM CATALOG_DB.dbo.Catalog
WHERE NrLeg>(SELECT NrLeg
FROM CATALOG_DB.dbo.Student
WHERE Nume = 'Popescu' AND Grupa='222')

SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as N
WHERE S.NrLeg=N.NrLeg
AND S.NrLeg=(SELECT TOP 1 S.NrLeg
FROM CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
WHERE N1.cod_disciplina=D.cod_disciplina AND
D.cod_disciplina>3) 

SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND S.NrLeg IN (SELECT N1.NrLeg
FROM CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
WHERE N1.cod_disciplina=D.cod_disciplina AND
D.cod_disciplina>3)

SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND S.NrLeg = ANY (SELECT N1.NrLeg
FROM CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
WHERE N1.cod_disciplina=D.cod_disciplina
AND
D.cod_disciplina>3)

SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND S.NrLeg > any (SELECT N1.NrLeg
 FROM CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
 WHERE N1.cod_disciplina=D.cod_disciplina AND
D.cod_disciplina>3)



SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND EXISTS (SELECT N1.NrLeg
FROM CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
WHERE N1.cod_disciplina=D.cod_disciplina AND
D.cod_disciplina>3)

SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND EXISTS (SELECT N1.NrLeg FROM
 CATALOG_DB.dbo.CATALOG AS N1, CATALOG_DB.dbo.DISCIPLINA AS D
 WHERE N1.cod_disciplina=D.cod_disciplina AND
 D.cod_disciplina>8)SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND S.NrLeg <> ALL (SELECT N1.NrLeg
FROM CATALOG_DB.dbo.CATALOG N1, CATALOG_DB.dbo.DISCIPLINA D
WHERE N1.cod_disciplina=D.cod_disciplina
AND D.cod_disciplina>3)SELECT S.NrLeg, Nume +' '+Prenume Student,Grupa, cod_disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT as S, CATALOG_DB.dbo.CATALOG as C
WHERE S.NrLeg=C.NrLeg
AND S.NrLeg >= all (SELECT N1.NrLeg
FROM CATALOG_DB.dbo.CATALOG N1, CATALOG_DB.dbo.DISCIPLINA D
WHERE N1.cod_disciplina=D.cod_disciplina AND
D.cod_disciplina>3)

SELECT S.NrLeg, Nume,Prenume ,Disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT AS S,CATALOG_DB.dbo.CATALOG AS C, CATALOG_DB.dbo.DISCIPLINA AS D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nume in (SELECT Nume
FROM CATALOG_DB.dbo.STUDENT
WHERE Nume not like '%escu')

SELECT S.NrLeg, Nume,Prenume ,Disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT AS S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nume =any (SELECT Nume
FROM CATALOG_DB.dbo.STUDENT
WHERE Nume  not like '%escu')

SELECT S.NrLeg, Nume,Prenume ,Disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nume <> all (SELECT Nume
FROM CATALOG_DB.dbo.STUDENT
WHERE Nume like '%escu')

SELECT S.NrLeg, Nume,Prenume ,Disciplina, Nota
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nume <> all (SELECT Nume
FROM CATALOG_DB.dbo.STUDENT
WHERE Nume  like '%escu')

SELECT S.NrLeg Legitimatie, Nume+' '+Prenume Student,
AVG(Nota)Media
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nume in (SELECT Nume
FROM CATALOG_DB.dbo.STUDENT
WHERE Nume like 'Pop%')
GROUP by S.NrLeg,Nume+' '+PrenumeSELECT S.NrLeg Legitimatie, Nume+' '+Prenume Student, Nota
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
AND Nota > (SELECT AVG(Nota)
 FROM CATALOG_DB.dbo.CATALOG )
Order by S.NrLeg

SELECT S.NrLeg Legitimatie, Nume+' '+Prenume Student, AVG(Nota)
Media
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C, CATALOG_DB.dbo.DISCIPLINA D
WHERE S.Nrleg=C.NrLeg
AND D.cod_disciplina=C.cod_disciplina
GROUP BY S.NrLeg,Nume+' '+Prenume
HAVING AVG(Nota) > (SELECT top 1 AVG(Nota)
FROM CATALOG_DB.dbo.CATALOG )
Order by S.NrLeg

SELECT *
FROM CATALOG_DB.dbo.STUDENT S
WHERE S.NrLeg in (SELECT S1.NrLeg
 FROM CATALOG_DB.dbo.STUDENT S1, CATALOG_DB.dbo.CATALOG C
 WHERE S1.NrLeg=C.NrLeg
 AND Nota>(SELECT avg(Nota)
FROM CATALOG_DB.dbo.CATALOG ))

SELECT *
FROM CATALOG_DB.dbo.STUDENT S
WHERE S.NrLeg in (SELECT S1.NrLeg 
FROM CATALOG_DB.dbo.STUDENT S1, CATALOG_DB.dbo.CATALOG C
WHERE S1.NrLeg=C.NrLeg
GROUP by S1.NrLeg
HAVING avg(C.Nota)>(SELECT avg(Nota)
 FROM CATALOG_DB.dbo.CATALOG ) )SELECT *
FROM CATALOG_DB.dbo.CATALOG C
WHERE 'Popescu'=(SELECT Nume
FROM CATALOG_DB.dbo.STUDENT S
WHERE S.NrLeg=C.NrLeg)
SELECT S.NrLeg, avg(C.Nota) Media, Count(S.NrLeg) NrMaterie
FROM CATALOG_DB.dbo.STUDENT S, CATALOG_DB.dbo.CATALOG C
WHERE S.NrLeg=C.NrLeg
AND C.Nota> =(SELECT avg(C1.Nota)
FROM CATALOG_DB.dbo.STUDENT S1,CATALOG_DB.dbo.CATALOG C1
WHERE S1.NrLeg=C1.NrLeg AND C1.NrLeg=S.NrLeg)
GROUP by S.NrLeg
SELECT S.NrLeg, max(C.Nota) Nota_Max, Count(S.NrLeg) NrMaterie
FROM  CATALOG_DB.dbo.STUDENT S,  CATALOG_DB.dbo.CATALOG C
WHERE S.NrLeg=C.NrLeg
GROUP by S.NrLeg
HAVING max(C.Nota)>=(SELECT avg(C1.Nota)
FROM  CATALOG_DB.dbo.STUDENT S1, CATALOG_DB.dbo.CATALOG C1
WHERE S1.NrLeg=C1.NrLeg AND C1.NrLeg=S.NrLeg)

SELECT S.NrLeg, avg(C.Nota) Media
FROM CATALOG_DB.dbo.STUDENT S,CATALOG_DB.dbo.CATALOG C
WHERE S.NrLeg=C.NrLeg
GROUP by S.NrLeg