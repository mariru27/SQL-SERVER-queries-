--Exemplul 1. Subinterogarea determină toţi clienţii care sunt din acelaşi oraş cu Albu:
SELECT *
FROM clienţi
WHERE oraş=
(SELECT oraş
FROM clienţi
WHERE NUME=‟Albu‟)


--Exemplul 2. Determinaţi toţi clienţii din oraşul celui cu comanda 1015:
SELECT *
 FROM clienţi
 WHERE oraş=
(SELECT oraş
FROM companie
WHERE NR_COM=1015)--Exemplul 3. Următoarea subinterogare furnizează fabricile care au termenul de livrare
--mai mic decât termenul de livrearea a lui DAEWO.
SELECT *
FROM fabrici
WHERE termen_liv <(SELECT termen_liv
FROM fabrici
WHERE ID_FABRICA=”DAEWO”)


--Exemplul 4.Utlizarea cuvântului cheie ALL inaintea unei subinterogare determină când
--comparaţia este adevărată pentru orice valoare returnată. Determinaţi comenzile şi
--articolele şi fabricile care contin articole ale căror preţuri sunt mai mici decât preţul
--oricărui articol din comanda 1023.
SELECT NR_COM, CD_ART, ID_FABR, PREŢ
FROM articole
WHERE PREŢ<ALL (SELECT PRET FROM aticole
WHERE NR_COM=1023)


--Exemplu 5.Utilizarea cuvântului cheie înaintea unei subinterogări determină când
--comparaţia este adevărată pentru cel puţin o valoare returnată.
SELECT DISTINCT NR_COMANDA
FROM articole
WHERE PREŢ_TOTAL>ANY(SELECT PRET_TOTAL)
 FROM articole
 WHERE NR_COMANDA=1005


--Exemplu 6. Fie tabelele:
--articole (ID_ART, DENUMIRE, ID_FABR, PRET_UNIT)
--fabrici (ID_FABR, NUME_FABR, ORAS, STRADA, NR)
--Determinaţi articolele care sunt făcute de o fabrică din Bucureşti.
SELECT ID_ART, DENUMIRE
FROM articole
WHERE ID_FABR IN (SELECT ID_FABR)
 FROM fabrici
 WHERE ORAS = „Bucureşti‟)

--Exemplu 7.Fie tabelele:
--clienti(ID_CL, NUME_CL, PREN_CL, ORAS, STR, NR)
--comenzi(NR_COMANDA, DATA_COM, ID_CL, DATA, LIVRĂRI)
--Determinaţi clienţii care nu au nici o comandă:
SELECT NUME_CL, PREN_CL
FROM clienţi
WHERE ID_CL NOT IN (SELECT ID_CL
 FROM comenzi)


--Exemplu 8. Fie tabelele din exemplu 6. Determinaţi articolele care au preţul de 10 ori
--preţul unitar minim. 
SELECT ID_ART, DENUMIRE, ID_FABR
FROM articole
WHERE PRET_UNIT > (SELECT 10*MIN(PRET_UNIT)
 FROM articole)

 --Exemplu 9. Aceleaşi tabele de la exemplu 6
SELECT ID_ART, DENUMIRE, ID_FABR
FROM articole
WHERE PRET_UNIT < (SELECT AVG(PRET_UNIT)
FROM articole)


--Exemplu 10. Fie tabelul:

--comenzi(NR_COM, DATA_COMENZII, DATA_LIVRARI, ID_CL)
--Întrebarea este un exemplu de întrebare corectă ce returnează o listă a primelor 10 date
--de livrare din tabelul de comenzi.
SELECT DATA_LIVRĂRII
FROM comenzi a
 WHERE 10>(SELECT COUNT(*)
 FROM comenzi b
 WHERE b.DATA_LIVRARII>a.DATA_LIVRARII)
 AND DATA_LIVRARII IS NOT NULL
ORDER BY DATA_LIVRARII


--Exemplu 11. Fie tabelul de articole din exemplul din exemplu 4 şi tabelul de comenzi din
--exemplu 8. Determinaţi comenzile care au mai mult de 3 articole.
SELECT NR_COM
FROM comenzi c
WHERE 3<(SELECT COUNT(*)
 FROM articole a
 WHERE c.NR_COM = a.NR_COM)


--Exerciţiu. Determinaţi produsele care sunt fabricate de cel puţin 2 fabrici.
--Exemplu 12.Fie tabelele de comenzi şi de articole din exemplul 7.
--Determinaţi toate comenzile de CIELO
SELECT *
FROM comenzi c
WHERE “CIELO” = (SELECT DENUMIRE
 FROM articole a
 WHERE c.ID_AR=a.ID_ART)

--EXISTS este o funcţie predicat care acceptată ca paramentru unic a subinterogării.
--Dacă o interogarea returnează o mulţime de rezultate atunci EXISTS returnează TRUE în
--caz contrar FALSE:
--Exemplu 13.Fie tabelele:
--titlu (ID_TITLU, DENUMIRE_T, SAL_ORA)
--salariati(ID_SALARIAT, NUME, PREN, ID_TITLU, ADR)
--Determinaţi titlurile pentru care există salariaţi:
SELECT ID_TITLU, DENUMIRE_T
FROM titlu t
WHERE EXISTS (SELECT *
 FROM salariati s
 WHERE t.ID_TITLU=s.ID_TITLU )


--Exemplu 14. Determinaţi titlurile pentru care nu există salariaţi.
 SELECT ID_TITLU, DENUMIRE_T
FROM titlu t
WHERE NOT EXISTS (SELECT *
 FROM salariati s
 WHERE t.ID_TITLU=s.ID_TITLU )


--Exemplu 15. Determinaţi fabricile şi produsele pentru care nu a existat nici o comanda.
SELECT ID_ART, ID_FABR
FROM produse p
WHERE NOT EXISTS (SELECT ID_ART, ID_FABR
 FROM articole a
WHERE p.ID_ART = a.ID_ART
 AND p.ID_FABR=a.ID.FABR )

--Exemplu 16. Aceasta este echivalenţă cu cea din exemplu 4.
SELECT NR_COM
FROM articole
WHERE PRET_TOTAL>(SELECT max(PRET_TOTAL))
FROM ARTICOLE
WHERE NRCOM=1023)


--Exemplu 17. Această subinterogare determină comenzile care au valoarea mai mică
--decât valoarea medie:
SELECT c.NR_COM
FROM comenzi c, articole a
WHERE c.NR_COM = s.NR_COM
AND PRET_TOTAL *
(SELECT AVG(PRET_TOTAL))
FROM articole
WHERE c.NR_COM = a.NR_COM)

--Exemplu 18. Această instrucţiune SELECT returnează numărul tuturor comenzilor care
--conţin un articol al cărui PRET_TOTAL este mai mare decât pretul total al cel putin unui
--articol din comanda cu numărul 1023. Ea poate fi scrisă cu ajutorul cuvântului cheie ANY
--sau cu ajutorul funcţiei MIN.
SELECT DISTINCT NR_COM
FROM articole
WHERE PRET_TOTAL > ANY (SELECT PRET_TOTAL
 FROM articole
WHERE NR_COM=1023)
Exemplu 19. Aceasta este echivalentă cu 18.
SELECT DISTINCT NR_COM
FROM articole
WHERE PRET_TOTAL >(SELECT MIN(PRET_TOTAL))
 FROM articole
WHERE NR_COM=1023)

--Utilizarea unei condiţii de unire în cauza where
--Când se unesc 2 tabele trebue creată o legătură în clauza WHERE prin cel puţin a
--coloană dintr-un tabel şi o coloana din alt tabel.
--Efectul este un tabel compus care e temporar, în care fiecare pereche de linii satisface
--legătura, condiţiile de unire formează o singură linie. Putem crea autouniri (unirea unui
--tabel cu el însuşi) unirea a 2 tabele sau a unirea a mai multor tabele.
--Exemplu 20. Exemplu de unire a doua tabele:
SELECT NUME, PREN, NR_COM
FROM clienţi, comenzi
WHERE clienti.NR_CL=comenzi.NR_CL

--Exemplu 21. Autounirea (SELF JOIN) crează o listă de articole din atibutul stoc care
--sunt produse de 3 fabrici:
SELECT a.ID_FABR, b.ID_FABR, c.ID_FABR, c.ID_ART
FROM stoc a, stoc b, stoc c
WHERE a. ID_ART= b.ID_ART
 AND a. ID_ART= c.ID_ART
 AND a. ID_FABR< b.ID_FABR
 AND b. ID_FABR< c.ID_FABR)
ORDER BY ID_ART

--Exemplu 22. Comenzile care au fost comandate în aceeaşi zi de 2 ori se consideră
--duplicate şi se elimină una.
SELECT *.NUME_CL, *.DATA_COMENZII
FROM emitere-comenzi x
WHERE 1<(SELECT COUNT(x)
FROM emitere-comenzi y
WHERE x. NUME_CL =y. NUME_CL)

----------------------------------------------------------EXERCITII-----------------------------------------------------------------

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




