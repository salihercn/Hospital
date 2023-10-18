--1)  hen�z kay�tl� olmayan t�m hem�ilerle ilgili t�m bilgileri getirin ? *

SELECT * 
FROM Nurse
WHERE Registered=0


--2)  Hem�irelerden ba� hem�irenin ismini bulan sql sorgusunu yaz�n�z ? * 

SELECT Name
FROM Nurse
WHERE Position='Head Nurse'


--3)  Her bir b�l�m�n ba��ndaki doktorun ismini bulan bir sql sorgusunu yaz�n�z ? *  

SELECT P.Name As [Physician Name],
       D.Name As [Department Name]
FROM Physician P
LEFT OUTER JOIN Department D ON P.EmployeeID=D.Head
WHERE D.Name IS NOT NULL

--4)  En az bir doktordan randevu alan hasta say�s� getiren bir sql sorgusu yaz�n�z ? *

SELECT COUNT(Patient) as [Number of Appointment],Patient
FROM Appointment
GROUP BY Patient
HAVING COUNT(Patient)=1

--5)  212 numaral� odan�n blok ve kat numaras�n� bulan sql sorgusunu yaz�n�z ? *

SELECT 
RoomNumber,
BlockCode,
BlockFloor
FROM Room
WHERE RoomNumber=212

--6)  Hastalar i�in m�sait olan odalar�n say�s�n� bulan bir sql sorgusu yaz�n�z ? *

SELECT *
FROM Room
WHERE Unavailable=0

--7)  Hangi doktorun hangi bran�a ait oldu�unu bulan bir sql sorgusu yaz�n�z ? **

SELECT P.Name as [Physician Name],
	   D.Name as [Department] 
FROM Physician P
LEFT OUTER JOIN Affiliated_With AW ON P.EmployeeID=AW.Physician
LEFT OUTER JOIN Department D on D.DepartmentID=AW.Department

--8)  Hangi doktorun hangi tedavi y�ntemleri konusunda e�itim ald���n� getiren bir sql sorgusu yaz�n�z ? **

SELECT P.Name as [Physician Name],
	   T.Treatment 
FROM Physician P
LEFT OUTER JOIN Trained_In T ON p.EmployeeID=T.Physician

select * from [dbo].[Trained_In]

--9)  Uzmanla�mam�� doktorlar� bulan bir sql sorgusu yaz�n�z ? *

SELECT * 
FROM Physician
WHERE Position NOT LIKE '%Attending%' 

--10) Hastan�n ismi adresi ve muayane oldu�u doktrou getiren bir sql sorgusu yaz�n�z ? **

SELECT PA.Name AS [Patient Name],
	   PA.Address,
	   P.Name AS [Physician Name]
FROM Prescribes PR
LEFT OUTER JOIN Patient PA ON PR.Patient=PA.SSN
LEFT OUTER JOIN Physician P ON P.EmployeeID=PR.Physician

--11) Doktorlara al�nan randevu tablosundan hastan�n ismini ve hangi doktora randevu ald���n� getiren bir sql sorgusu yaz�n�z ?  ***

SELECT PA.Name AS [Patient Name],
	   P.Name AS [Physician Name]
FROM Patient PA
LEFT OUTER JOIN Appointment A ON A.Patient=PA.SSN
LEFT OUTER JOIN Physician P ON P.EmployeeID=A.Physician

--12) Doktor odas� C de ka� farkl� hasta bak�ld���n� getiren bir sql sorgusu yaz�n�z ? **

SELECT COUNT(Patient),Patient
	   FROM [dbo].[Appointment]
	   WHERE ExaminationRoom LIKE 'C'
	   GROUP BY Patient

--13) Hastan�n ismini ve muayene i�in gitmesi gereken doktor odas�n� getiren bir sql sorgusu yaz�n�z ? **

SELECT P.Name as [Patient Name],
	   A.ExaminationRoom	
FROM Patient P
LEFT OUTER JOIN Appointment A ON A.Patient=P.SSN

--14) Doktor odas�n� ve doktor odas�nda hz�r bulunmas� gereken hem�ireyi getiren bir sql sorgusu yaz�n�z ? **

SELECT N.Name as [Nurse Name],
	   ExaminationRoom 
FROM Nurse N
LEFT OUTER JOIN Appointment A ON A.PrepNurse= N.EmployeeID

--15) 25 Nisan 2015 saat 10:00:00 da randevusu olan hastan�n doktorunun ismini ve doktor odas�n� getiren bir sql sorgusu yaz�n�z ? ***

select P.Name as [Patient Name],
	   PH.Name as [Physician Name],
	   A.ExaminationRoom	
from Patient P
left outer join Appointment A ON A.Patient=P.SSN
left outer join Physician PH ON PH.EmployeeID=A.Physician
where Start='2008-04-25 10:00:00.000'

---NOT: Bendeki tarih 2008 Hocam :)--

--16) Doktor muayenesi s�ras�nda hem�irenin asiste etmesine gerek olmayan hasta ve doktor ismini getiren bir sql sorgusu yaz�n�z ? ***

select P.Name as [Patient Name],
	   PH.Name as [Physician Name]
from Patient P
left outer join Appointment A ON A.Patient=P.SSN
left outer join Physician PH ON PH.EmployeeID=A.Physician
where PrepNurse is null

--17) Hastan�n ismini, doktorun ismini ve doktorun verdi�i ilac�n ismini getiren bir sql sorgusu yaz�n�z ? ***


select P.Name as [Patient Name], 
       PH.Name as [Phycian Name],
	   M.Name as [Medication Name]
from Patient P
right outer join Prescribes PR on PR.Patient=P.SSN
left outer join Physician PH on PH.EmployeeID=PR.Physician
left outer join Medication M on M.Code=PR.Medication

--18) Muayenede doktor taraf�ndan  tekrar randevu verilen hastan�n ismini,doktorun ismini doktorun verdi�i ilac� getiren bir sql sorgusu yaz�n�z ? ***

select P.Name as [Patient Name],
	   PH.Name as [Physician Name],
	   M.Name as [Medication Name]	
from Appointment A
left outer join Patient P on P.SSN=A.Patient
left outer join Physician PH on PH.EmployeeID=A.Physician
right outer join Prescribes PR on PR.Patient=P.SSN
left outer join Medication M on M.Code=PR.Medication
group by P.Name,PH.Name, M.Name
having count(A.Patient)>1

--19) Muayenede doktor taraf�ndan tekrar randevu verilmeyen hastan�n ismini,doktorun ismini ve doktorun verdi�i ilac�n getiren bir sql sorgusu yaz�n�z ? ***

select count(A.Patient),
	   P.Name as [Patient Name],
	   PH.Name as [Physician Name],
	   M.Name as [Medication Name]	
from Appointment A
left outer join Patient P on P.SSN=A.Patient
left outer join Physician PH on PH.EmployeeID=A.Physician
left outer join Prescribes PR on PR.Patient=P.SSN
left outer join Medication M on M.Code=PR.Medication
group by P.Name,PH.Name, M.Name
having count(A.Patient)=1
order by 1

--SELECT P.Name
--FROM Appointment A
--LEFT OUTER JOIN Patient P ON P.SSN=A.Patient
--GROUP BY P.Name
--HAVING COUNT(A.Patient)=1

--20) Room tablosundaki her bir blok i�in ka� tane uygun oda oldu�unu  getiren bir sql sorgusu yaz�n�z ? **
	
	select BlockCode,
		   count(Unavailable) as [Available Room]
	from Room
	where Unavailable=0
	group by BlockCode  

--21) Her bir kattaki uygun oda say�s�n� getiren bir sql sorgusu yaz�n�z ?  **

 select BlockCode,
		BlockFloor,
		count(Unavailable) as [Available Room]
 from Room
 where Unavailable=0
 group by BlockCode,BlockFloor 

 --22) Ayn� kattaki bulunan her bir blocktaki uygun odalar�n say�s�n� getiren bir sql sorgusu yaz�n�z ? **

  select BlockFloor,
		 BlockCode,
		 count(Unavailable) as [Available Room]
 from Room
 where Unavailable=0
 group by BlockFloor,BlockCode
 order by BlockFloor

 --23) Ayn� kattaki bulunan her bir blocktaki uygun olmayan odalar�n say�s�n� getiren bir sql sorgusu yaz�n�z ? **

   select BlockFloor,
		  BlockCode,
		  count(Unavailable) as [Unavailable Room]
 from Room
 where Unavailable=1
 group by BlockFloor,BlockCode
 order by BlockFloor

 --24) En fazla uygun oda olmayan kat� getiren bir sql sorgusu yaz�n�z ? **

   select BlockFloor,
		count(Unavailable) as [Unavailable Room]
   from Room
   where Unavailable=1
   group by BlockFloor	  

--25) En fazla uygun oda bulunan kat� getiren bir sql sorgusu yaz�n�z ? **

   select BlockFloor,
	    count(Unavailable) as [Unavailable Room]
   from Room
   where Unavailable=0
   group by BlockFloor

--26) Hastan�n ismini tedavi g�rd��� oda numaras�n� block unu ve hangi katta tedavi g�rd���n� getiren bir sql sorgusu yaz�n�z ? ***

	
	
	select P.Name as [Patient Name],
		   S.Room,
		   R.BlockCode,
		   R.BlockFloor 
	from Stay S
	left outer join Patient P on P.SSN=S.Patient
	left outer join Room R on R.RoomNumber=S.Room

--27) Hangi hem�irenin hangi kat ve block ta g�revli oldu�unu getiren bir sql sorgusu yaz�n�z ? ***


	select  N.Name,
			O.BlockCode,
			O.BlockFloor 
	from On_Call O
	left outer join Nurse N on N.EmployeeID=O.Nurse 
	
--28) Patronunuz sizden tedavi olan ve hastanede yat�� yapan hastalar i�in kapsaml� bir rapor istedi ve bu sql sorgusunu yazmak zorundas�n�z
--		Bu tabloda neler olacak:
---		Hastan�n ismi
---		Hastay� tedavi eden doktorun ismi
---		Tedavi s�ras�nda bulunan hem�irenin ismi
---		Hastaneden tedavi olma tarihi
---		Hastan�n hangi odada kald���
---		Odan�n bulundu�u kat ve blok numaras�n� getiren bir sql sorgusu yaz�n�z ? ****


	select P.Name as [Patient Name],
		   PH.Name as [Physician Name],
		   N.Name as [Nurse Name],
		   S.StayEnd,
		   S.Room,
		   R.BlockCode,
		   R.BlockFloor 
	from Stay S
	left outer join Patient P on P.SSN=S.Patient
	left outer join Room R on R.RoomNumber=S.Room
	left outer join Undergoes U on U.Patient=S.Patient	
	left outer join Physician PH on PH.EmployeeID=U.Physician
	right outer join Nurse N on N.EmployeeID=u.AssistingNurse

--29) Doktorlardan tedavi yapmayas�na ra�men o bran�la ilgili sertikas� bulunmayan doktorlar�n ismini getiren bir sql sorgusu yaz�n�z ? ****


select P.EmployeeID,
	   P.Name,
	   T.Treatment 
from Physician P
left outer join Undergoes U on P.EmployeeID=U.Physician
left outer join Trained_In T on P.EmployeeID=T.Physician
where T.Treatment is null 

--30) Doktorlardan tedavi yapmayas�na ra�men o bran�la ilgili sertikas� bulunmayan doktorlar�n ismini yapt��� tedaviyi tedavinin
--zaman�n� ve hangi hastaya uygulad���n� bulan sql sorgusu yaz�n�z ? ****

select P.EmployeeID,
	   T.Treatment,
	   P.Name,
	   PR.Code,
	   PR.Name,
	   U.DateUndergoes,
	   PA.Name
from Undergoes U
inner join Trained_In T on T.Physician=U.Physician
left outer join Physician P on P.EmployeeID=U.Physician
left outer join Trained_In T on U.Physician=T.Physician
left outer join Procedures PR on PR.Code=U.Procedures
left outer join Trained_In TI on TI.Treatment=U.Procedures
left outer join Patient PA on PA.SSN=U.Patient 
where U.Physician = T.Physician
group by P.EmployeeID,P.Name,PR.Code,PR.Name,U.DateUndergoes,PA.Name,T.Treatment




 
 /*
Exercice 26:Hastan�n ismini tedavi g�rd��� oda numaras�n� block unu ve hangi katta tedavi g�rd���n� result tablosuna 
bast�ran bir sql sorgusu yaz�n�z
*/
Select p.name as hasta,
s.room as oda_no,
r.BlockFloor as Kat_no,
r.BlockCode as blok
from stay s
join Patient p on s.Patient=p.SSN
join room r on s.Room=r.RoomNumber
/*
Exercice 27:Hangi hem�irenin hangi kat ve block ta g�revli oldu�unu result tablosuna basan bir sql sorgusu yaz�n�z
*/
select 
n.Name as hem�ire_ad�,
o.BlockCode as blok,
o.BlockFloor as kat
from nurse n
join On_Call o on o.Nurse=n.EmployeeID
/*
Exercice 28:Patronunuz sizden tedavi olan ve hastanede yat�� yapan hastalar i�in kapsaml� bir rapor istedi ve bu sql sorgusunu yazmak zorundas�n�z
Bu tabloda neler olacak:
-Hastan�n ismi
-Hastay� tedavi eden doktorun ismi
-Tedavi s�ras�nda bulunan hem�irenin ismi
-Hastaneden tedavi olma tarihi
-Hastan�n hangi odada kald���
-Odan�n bulundu�u kat ve blok numaras�n�

result tablosuna yazd�ran sql sorgusunu yaz�n�z.

*/
select 
p.Name as hasta,
phy.name as doktor,
n.name as hem�ire,
u.DateUndergoes as tedavi_tarihi,
r.RoomNumber as oda_numaras�,
r.BlockFloor as bulundu�u_kat,
r.BlockCode as bulundu�u_blok
from Undergoes u 
join Patient p     on u.Patient=p.ssn
join Physician phy on u.Physician=phy.EmployeeID
left join nurse n  on u.AssistingNurse=n.EmployeeID
join stay s		   on u.Stay=s.StayID
join room r		   on s.Room=r.RoomNumber
 

/*
Exercice 29:Doktorlardan tedavi yapmayas�na ra�men o bran�la ilgili sertikas� bulunmayan doktorlar�n ismini result tablosuna bas�n�z
*/
select * from Physician 
where EmployeeID in (
select u.Physician 
from Undergoes u
left join Trained_In t on u.Physician=t.Physician and u.Procedures=t.Treatment
where Treatment is null)

/*
Exercice 30:Doktorlardan tedavi yapmayas�na ra�men o bran�la ilgili sertikas� bulunmayan doktorlar�n ismini yapt��� tedaviyi tedavinin
zaman�n� ve hangi hastaya uygulad���n� bulan bir sql sorgusu yaz�n�z
*/
select 
p.name as doktor,
pr.name as tedavi,
u.DateUndergoes as tarih,
pt.name as hasta
from Physician p, Undergoes u, Patient pt, Procedures pr
where u.Patient=pt.ssn
and u.Procedures=pr.code
and u.Physician=p.EmployeeID
and not exists
(
select * from Trained_In t
where t.Treatment=u.Procedures
and t.Physician=u.Physician
)

/*
Exercice 31:122 numaral� odada yatan hastan�n �a��rabilece�i hem�irelerin isimlerini result tablosuna bast�ran bir sql sorgusu yaz�n�z
*/
select * from nurse n
where n.EmployeeID in
(select c.Nurse from On_Call c,room r
where c.BlockFloor=r.BlockFloor
and c.BlockCode=r.BlockCode
and r.RoomNumber=122)


/*
Exercice 32:Hastaneye ilk s�radan gelen hastay� ila�la tedavi eden doktorunun ismini result tablosuna basan bir
sql sorgusu yaz�n�z
*/
select pt.name as hasta, p.name as doktor
from Patient pt
join Prescribes pr  on pr.Patient=pt.SSN
join Physician p	on pt.pcp=p.EmployeeID
where pt.pcp=pr.Physician
and pt.pcp=p.EmployeeID

/*
Exercice 33:Hastaneye yatarak tedavi olmak i�in ilk s�rada gelen hastadan maliyeti 5000 dolar� ge�en tedaviler i�in
hastan�n ismini doktorun ismini ve maliyetini result tablosuna basan bir sql sorgusu yaz�n�z
*/
select pt.Name as hasta,
p.name  as doktor,
pd.Cost as maliyet
from Patient pt
join Undergoes u   on u.Patient=pt.SSN
join Physician p   on pt.pcp=p.EmployeeID
join Procedures pd on u.Procedures=pd.Code
where Patient=100000001 and pd.cost >5000








--





select * from Stay

select * from Appointment

select * from Patient

select * from Undergoes

select * from Trained_In

select * from Physician

select * from Department

select * from Prescribes

select * from Procedures





   




   
 
