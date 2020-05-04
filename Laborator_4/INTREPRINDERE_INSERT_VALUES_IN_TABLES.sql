
INSERT INTO INTREPRINDERE.dbo.SECTII(Nume,Buget)
VALUES 
 ('Ingineri',2400000),
 ('Furnizori',2900000),
 ('Vanzator',1000000),
 ('Achizitor',230000),
 ('Productie',120000);



INSERT INTO INTREPRINDERE.dbo.INGINERI(IdAngajat,Specialitatea)
VALUES (1,'Electronica'),
 (6,'Electronica'),
 (7,'Electronica'),
 (8,'Specialitate1'),
 (9,'Electronica'),
 (10,'Specialitate2');

 
INSERT INTO INTREPRINDERE.dbo.ANGAJATI(Nume,Prenume,Data_Nasetii,Adresa,Functie,Salariu,IdSectie)
VALUES ('Mihai','Ion','1991-02-03','str.Dragomir','Ingineri',2000,5),
 ('Ioana','Mihail','1990-04-03','str.Dragomir','Furnizori',2010,2),
 ('Maria','Popescu','1994-01-03','str.Dragomir','Vanzator',4000,3),
 ('Vasile','Cojocaru','1994-02-20','Bucuresti','Vanzator',3000,3),
 ('Dumitru','Boboc','1991-02-23','Bucuresti','Vanzator',3400,3),
 ('Valeriu','Matasari','1994-05-13','str.Dragomir','Ingineri',3000,1),
 ('Alex','Rusu','1992-08-01','str.Dragomir','Ingineri',1000,1),
 ('Alexandru','Piciorus','1996-02-03','str.Dragomir','Ingineri',4000,1),
 ('Mihai','Goru','1996-09-13','Bucuresti','Furnizori',3000,1),
 ('Andrei','Bobel','1990-10-14','str.Dragomir','Ingineri',2500,1),
 ('Andrei','Gorceag','1992-11-04','Bucuresti','Achizitor',2500,4),
 ('Mihai','Noc','1994-10-24','Bucuresti','Achizitor',2500,4);



INSERT INTO INTREPRINDERE.dbo.FURNIZOR(Nume,Prenume,Adresa)
VALUES ('Mihai','Anrei','Craiova'),
 ('Andrei','Popa','Bucuresti'),
 ('Ioana','Vasile','Iasi');

 SELECT * FROM INTREPRINDERE.dbo.COMPONENTE;

INSERT INTO INTREPRINDERE.dbo.COMPONENTE(Denumire,Descriere)
VALUES ('Compresor','Un Compresor'),
 ('Bobina','Bobina este în electrotehnică un dispozitiv electric pasiv'),
 ('Lapte','folosit pentru producerea smantanii sau clatite'),
 ('Faina','folosit pentru clatite'),
 ('Ou','folosit pentru clatite'),
 ('Rezistenta','descriere rezistentaa'),
 ('Monitor','toate componentele pentru monitor');

SELECT * FROM INTREPRINDERE.dbo.CLIENTI;

INSERT INTO INTREPRINDERE.dbo.PRODUSE(Denumire,Descriere)
VALUES ('Condensator','dispozitiv ce condenseaza'),
 ('Clatite','din lapete,oua si faina'),
 ('Smantana', 'produs obtinut din lapte'),
 ('Monitor','produs din toate componentele pentru monitor');

INSERT INTO INTREPRINDERE.dbo.CLIENTI(Nume,Prenume,Adresa)
VALUES ('Mihai','Ion','Pitesti'),
 ('Vasile','Popoa','Bucuresti'),
 ('Vlad','Matasari','Pitesti'),
 ('Mihai','Coli','Craiova'),
 ('Andrei','Boli','Iasi'),
 ('Tudor','Ion','Bucuresti'),
 ('Tudor','Bipo','Iasi'),
 ('Ana','Cara','Bucuresti'),
 ('Mihaela','Cala','Craiova'),
 ('Alexa','Napa','Bucuresti'),
 ('Vio','Bobeca','Craiova'),
 ('Mary','Ion','Bucuresti'),
 ('Mihai','Popa','Bucuresti');

INSERT INTO INTREPRINDERE.dbo.DEPENDENTI(IdAngajat,Nume,Prenume,DataNasterii,GradRudenie)
VALUES (1,'Mihai','Vasile','1989-01-02',2),
 (1,'Jar','Mihai','1893-01-08',1),
 (2,'Ana','Flore','1987-02-02',1);



 SELECT * FROM INTREPRINDERE.dbo.PROIECTE;

INSERT INTO INTREPRINDERE.dbo.PROIECTE(Denumire,Termen,Buget)
VALUES ('Clatite bune','2025-10-22',203000),
 ('Condensator','2040-12-10',323000),
 ('Smantana de casa','2030-08-23',2000030),
 ('Monitor','2021-02-20',2332131),
 ('Sistem de achizitii de date','2029-03-09',2334224);

 INSERT INTO INTREPRINDERE.dbo.ACTIVITATI(IdProiect,IdAngajat,Ore)
VALUES (1,1,10),
 (1,6,10),
 (2,8,8),
 (2,7,8),
 (3,9,9),
 (3,10,9),
 (5,1,8),
 (5,2,8),
 (5,3,8);



INSERT INTO INTREPRINDERE.dbo.VANZARI(IdProdus,IdClient,IdVanzator,Dataa,NrProduse)
VALUES (1,1,3,'2010-02-01',310),
 (1,3,4,'2014-06-01',910),
 (1,4,3,'2012-02-01',410),
 (1,5,3,'2016-02-11',200),
 (3,6,3,'2018-04-01',210),
 (2,7,3,'2011-06-01',610),
 (2,2,5,'2011-01-01',110),
 (4,1,3,'2010-10-10',10),
 (4,2,4,'2009-02-05',20),
 (4,4,4,'2009-04-05',30);



INSERT INTO INTREPRINDERE.dbo.COMPOZITIE(IdComponenta,IdProdus,NrComponente)
VALUES (1,3,8),
 (3,2,2),
 (4,2,1),
 (5,2,4),
 (1,1,2),
 (7,4,20);

 SELECT * FROM INTREPRINDERE.dbo.ACHIZITII;

 SET IDENTITY_INSERT INTREPRINDERE.dbo.ACHIZITII ON;

INSERT INTO INTREPRINDERE.dbo.ACHIZITII(IdFurnizor,IdComponenta,IdAchizitie,Dataa,NrComponente,PretUnitar)
VALUES 
 (2,3,7,'2010-08-02',200,40),
 (1,1,4,'2010-03-04',400,30),
 (1,1,11,'2010-03-04',20,30),
 (1,2,12,'2011-12-18',11,20),
 (2,3,9,'2002-10-07',17,10),
 (2,4,1,'2010-07-11',20,12),
 (3,5,6,'2019-09-21',10,50),
 (1,6,2,'2010-02-04',10,20),
 (2,6,3,'2011-12-02',30,15),
 (1,7,5,'2010-10-10',20,1000);
