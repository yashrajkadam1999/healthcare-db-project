-- ============================================================
-- healthcare management system
-- complete database setup script
-- yashraj kadam
-- ==========================================================
--Sprint 1 — Database Setup
--DDLSprint 1
--NormalizationSprint 1
--FK constraintsSprint 1
--Identity columnsSprint 1
--DMLSprint 2
--Insert order for FKSprint 2
--ViewsSprint 3
--Inline TVFSprint 4, Sprint 9
--Stored proceduresSprint 5, Sprint 6, Sprint 7, Sprint 8, Sprint 9, Sprint 10, Sprint 11, Sprint 12
--Dynamic SQLSprint 5, Sprint 8, Sprint 9, Sprint 10
--sp_executesqlSprint 5, Sprint 8, Sprint 9, Sprint 10
--SQL injection preventionSprint 5, Sprint 8, Sprint 9, Sprint 10
--Default parametersSprint 5, Sprint 6, Sprint 7, Sprint 9, Sprint 10
--Table variable Sprint 6
--Temp table Sprint 6 
--Aggregations Sprint 6, Sprint 7
--CTE Sprint 7
--Window functions Sprint 7
--dense_rank Sprint 7
--Recursive CTE Sprint 8
--MAXRECURSION Sprint 8
--Scalar UDF Sprint 9
--MSTVF Sprint 9
--IF/ELSE Sprint 10
--CASE Sprint 10
--WHILE Sprint 10
--RETURN Sprint 10
--Clustered index Sprint 11
--Nonclustered index Sprint 11
--Covering index Sprint 11
--Filtered index Sprint 11
--Columnstore index Sprint 11
--Composite index Sprint 11
--Execution plan analysis Sprint 11
--Fragmentation Sprint 12
--Reorganize Sprint 12
--Rebuild Sprint 12
--Fill factor Sprint 12
--pad_index Sprint 12
--Index maintenance SP Sprint 12



create database healthcaredb;
go

use healthcaredb;
go

-- ============================================================
-- drop tables if they exist (in reverse FK order)
-- ============================================================
if object_id('prescription', 'U') is not null drop table prescription;
if object_id('visit', 'U') is not null drop table visit;
if object_id('medicine', 'U') is not null drop table medicine;
if object_id('patient', 'U') is not null drop table patient;
if object_id('doctor', 'U') is not null drop table doctor;
if object_id('department', 'U') is not null drop table department;
go

-- ============================================================
-- create tables
-- ============================================================

create table department (
departmentid int identity(1,1) primary key,
departmentname nvarchar(100) not null
);

create table doctor (
doctorid int identity(1,1) primary key,
doctorname nvarchar(100) not null,
departmentid int not null foreign key references department(departmentid)
);

create table patient (
patientid int identity(1,1) primary key,
patientname nvarchar(100) not null,
dob date not null,
gender char(1) not null check (gender in ('M','F')),
contactnumber varchar(15) null
);

create table visit (
visitid int identity(1,1) primary key,
patientid int not null foreign key references patient(patientid),
doctorid int not null foreign key references doctor(doctorid),
visitdate date not null
);

create table medicine (
medicineid int identity(1,1) primary key,
medicinename nvarchar(100) not null,
dosageform nvarchar(50) null
);

create table prescription (
prescriptionid int identity(1,1) primary key,
visitid int not null foreign key references visit(visitid),
medicineid int not null foreign key references medicine(medicineid),
dosage nvarchar(100) not null
);
go

-- ============================================================
-- Sprint 2 — Data Load
-- ============================================================
insert into department (departmentname) values
('cardiology'),
('neurology'),
('orthopedics'),
('general medicine'),
('pediatrics'),
('dermatology'),
('oncology'),
('gastroenterology');
go

-- ============================================================
-- insert data: doctor
-- ============================================================
insert into doctor (doctorname, departmentid) values
('dr. anita sharma', 1),
('dr. rajesh mehta', 1),
('dr. priya nair', 2),
('dr. suresh patel', 2),
('dr. kavita desai', 3),
('dr. amit joshi', 3),
('dr. neha gupta', 4),
('dr. vikram singh', 4),
('dr. pooja iyer', 5),
('dr. arjun rao', 6),
('dr. meera kapoor', 7),
('dr. sanjay bose', 8);
go

-- ============================================================
-- insert data: patient
-- ============================================================
insert into patient (patientname, dob, gender, contactnumber) values
('rahul verma',       '1990-03-15', 'M', '9876543210'),
('sneha kulkarni',    '1985-07-22', 'F', '9823456781'),
('amit thakur',       '1978-11-05', 'M', '9712345678'),
('priya menon',       '1995-01-30', 'F', '9645678901'),
('rohit sharma',      '1982-09-18', 'M', '9534567890'),
('ananya reddy',      '2000-04-12', 'F', '9423456789'),
('vikram chaudhary',  '1970-06-25', 'M', '9312345678'),
('deepika pandey',    '1993-12-08', 'F', '9201234567'),
('arjun nair',        '1988-02-14', 'M', '9098765432'),
('kavya krishnan',    '2005-08-20', 'F', '8987654321'),
('suresh tiwari',     '1965-05-11', 'M', '8876543210'),
('meena shah',        '1998-10-03', 'F', '8765432109'),
('nikhil jain',       '1975-03-28', 'M', '8654321098'),
('pooja agarwal',     '1991-07-16', 'F', '8543210987'),
('ravi kumar',        '1983-01-09', 'M', '8432109876');
go

-- ============================================================
-- insert data: medicine
-- ============================================================
insert into medicine (medicinename, dosageform) values
('aspirin',           'tablet'),
('metformin',         'tablet'),
('atorvastatin',      'tablet'),
('amoxicillin',       'capsule'),
('omeprazole',        'capsule'),
('paracetamol',       'tablet'),
('ibuprofen',         'tablet'),
('cetirizine',        'tablet'),
('azithromycin',      'tablet'),
('pantoprazole',      'tablet'),
('losartan',          'tablet'),
('amlodipine',        'tablet'),
('insulin glargine',  'injection'),
('salbutamol',        'inhaler'),
('prednisolone',      'tablet');
go

-- ============================================================
-- insert data: visit
-- ============================================================
insert into visit (patientid, doctorid, visitdate) values
(1,  1,  '2024-01-10'),
(1,  1,  '2024-03-22'),
(2,  3,  '2024-01-15'),
(3,  5,  '2024-02-05'),
(3,  7,  '2024-04-18'),
(4,  9,  '2024-02-20'),
(5,  2,  '2024-03-01'),
(5,  2,  '2024-06-14'),
(6,  10, '2024-03-10'),
(7,  4,  '2024-03-25'),
(7,  11, '2024-05-30'),
(8,  6,  '2024-04-05'),
(9,  8,  '2024-04-12'),
(10, 9,  '2024-04-22'),
(11, 1,  '2024-05-03'),
(11, 12, '2024-07-19'),
(12, 3,  '2024-05-15'),
(13, 7,  '2024-06-01'),
(14, 5,  '2024-06-20'),
(15, 2,  '2024-07-08'),
(1,  4,  '2024-08-01'),
(2,  6,  '2024-08-15'),
(3,  8,  '2024-09-02'),
(4,  10, '2024-09-18'),
(5,  12, '2024-10-05');
go

-- ============================================================
-- insert data: prescription
-- ============================================================
insert into prescription (visitid, medicineid, dosage) values
(1,  1,  '75mg once daily'),
(1,  3,  '10mg once daily'),
(2,  1,  '75mg once daily'),
(2,  11, '50mg once daily'),
(3,  3,  '20mg once daily'),
(3,  8,  '10mg once daily'),
(4,  5,  '600mg twice daily'),
(4,  6,  '500mg as needed'),
(5,  7,  '200mg three times daily'),
(5,  6,  '500mg as needed'),
(6,  9,  '10mg once daily'),
(6,  14, '2 puffs twice daily'),
(7,  2,  '500mg twice daily'),
(7,  3,  '20mg once daily'),
(8,  2,  '500mg twice daily'),
(8,  13, '10 units at bedtime'),
(9,  8,  '10mg once daily'),
(9,  15, '5mg once daily'),
(10, 4,  '500mg three times daily'),
(10, 6,  '500mg as needed'),
(11, 11, '100mg once daily'),
(11, 12, '5mg once daily'),
(12, 1,  '75mg once daily'),
(12, 5,  '20mg once daily'),
(13, 7,  '400mg twice daily'),
(13, 10, '40mg once daily'),
(14, 14, '2 puffs as needed'),
(14, 15, '10mg once daily'),
(15, 9,  '10mg once daily'),
(16, 5,  '20mg once daily'),
(16, 10, '40mg once daily'),
(17, 3,  '40mg once daily'),
(17, 8,  '10mg once daily'),
(18, 2,  '1000mg twice daily'),
(18, 13, '20 units at bedtime'),
(19, 6,  '500mg as needed'),
(19, 7,  '400mg twice daily'),
(20, 1,  '75mg once daily'),
(20, 12, '10mg once daily'),
(21, 11, '50mg once daily'),
(21, 3,  '20mg once daily'),
(22, 8,  '10mg once daily'),
(22, 15, '5mg once daily'),
(23, 4,  '875mg twice daily'),
(23, 6,  '500mg as needed'),
(24, 9,  '10mg once daily'),
(24, 14, '2 puffs twice daily'),
(25, 2,  '500mg twice daily'),
(25, 13, '15 units at bedtime');
go

-- ============================================================
-- Sprint 3 — Reporting Views
-- ============================================================

-- view 1: clinical staff need to see patient visit history
-- who visited, which doctor, which department, when
create or alter view vw_patientvisithistory
as
select p.patientid, p.patientname, p.gender, v.visitid, v.visitdate, d.doctorname, dept.departmentname
from patient p
join visit v on p.patientid = v.patientid
join doctor d on v.doctorid = d.doctorid
join department dept on d.departmentid = dept.departmentid;

-- view 2: pharmacy team need full prescription details per visit
-- what medicine, what dosage, which doctor prescribed it
create or alter view vw_prescriptiondetails
as
select v.visitid, v.visitdate, p.patientname, d.doctorname, m.medicinename, m.dosageform, pr.dosage
from visit v
join patient p on v.patientid = p.patientid
join doctor d on v.doctorid = d.doctorid
join prescription pr on v.visitid = pr.visitid
join medicine m on pr.medicineid = m.medicineid;

--Display:
-- clinical staff
select * from vw_patientvisithistory;

-- filter by patient
select * from vw_patientvisithistory
where patientname = 'rahul verma';

-- pharmacy team
select * from vw_prescriptiondetails;

-- filter by doctor
select * from vw_prescriptiondetails
where doctorname = 'dr. anita sharma';



-- ============================================================
-- Sprint 4 — Patient Prescription Lookup
-- ============================================================
create or alter function udf_getprescriptionsbypatient
(@patientid int)
returns table
as
return (select v.visitid, v.visitdate, d.doctorname, m.medicinename, pr.dosage
from visit v
join doctor d on v.doctorid = d.doctorid
join prescription pr on v.visitid = pr.visitid
join medicine m on pr.medicineid = m.medicineid
where v.patientid = @patientid);

-- Display: pharmacy team looks up patient 1
select * from dbo.udf_getprescriptionsbypatient(1);

-- Display: combine with patient table for full details
select p.patientname, f.*
from patient p
cross apply dbo.udf_getprescriptionsbypatient(p.patientid) f
where p.patientname = 'rahul verma';


-- ============================================================
-- Sprint 5- Management Sales Report with Optional Filters
-- ============================================================

create or alter procedure usp_patientvisitsummary
@patientid int = null,
@departmentname nvarchar(100) = null,
@startdate date = null,
@enddate date = null
as
begin
declare @sql nvarchar(2000)

set @sql = N'
select p.patientid, p.patientname, v.visitdate, d.doctorname, dept.departmentname, m.medicinename, pr.dosage
from patient p
join visit v on p.patientid = v.patientid
join doctor d on v.doctorid = d.doctorid
join department dept on d.departmentid = dept.departmentid
join prescription pr on v.visitid = pr.visitid
join medicine m on pr.medicineid = m.medicineid
where 1 = 1'

if @patientid is not null
set @sql = @sql + N' and p.patientid = @patientid'

if @departmentname is not null
set @sql = @sql + N' and dept.departmentname = @departmentname'

if @startdate is not null
set @sql = @sql + N' and v.visitdate >= @startdate'

if @enddate is not null
set @sql = @sql + N' and v.visitdate <= @enddate'
set @sql = @sql + N' order by v.visitdate desc'

exec sp_executesql @sql,
N'@patientid int, @departmentname nvarchar(100), @startdate date, @enddate date',
@patientid = @patientid,
@departmentname = @departmentname,
@startdate = @startdate,
@enddate = @enddate
end;

-- Display: all records
exec usp_patientvisitsummary;

-- Display: filter by patient
exec usp_patientvisitsummary @patientid = 1;

-- Display: filter by department
exec usp_patientvisitsummary @departmentname = 'cardiology';

-- Display: filter by date range
exec usp_patientvisitsummary
@startdate = '2024-01-01',
@enddate = '2024-06-30';

-- Display: combine filters
exec usp_patientvisitsummary
@departmentname = 'cardiology',
@startdate = '2024-01-01',
@enddate = '2024-06-30';

-- ============================================================
--Sprint 6 — Monthly Department Summary Report
-- ============================================================

create or alter procedure usp_monthlydepartmentsummary
@month int,
@year int
as
begin

-- stage 1: table variable holds filtered visits for the given month and year
declare @filteredvisits table (visitid int,visitdate date,
patientid int,doctorid int,
departmentid int,departmentname nvarchar(100))

insert into @filteredvisits
select v.visitid, v.visitdate, v.patientid, v.doctorid, dept.departmentid, dept.departmentname
from visit v
join doctor d on v.doctorid = d.doctorid
join department dept on d.departmentid = dept.departmentid
where month(v.visitdate) = @month
and year(v.visitdate) = @year

-- stage 2: temp table holds aggregated summary for validation
create table #departmentsummary (
departmentname nvarchar(100),
totalvisits int,
totalprescriptions int)

insert into #departmentsummary
select
fv.departmentname,
count(distinct fv.visitid) as totalvisits,
count(pr.prescriptionid) as totalprescriptions
from @filteredvisits fv
left join prescription pr on fv.visitid = pr.visitid
group by fv.departmentname

-- return final validated summary
select * from #departmentsummary
order by totalvisits desc

drop table #departmentsummary
end;

-- Display: january 2024 summary
exec usp_monthlydepartmentsummary @month = 1, @year = 2024;

-- Display: march 2024 summary
exec usp_monthlydepartmentsummary @month = 3, @year = 2024;

-- ============================================================
--Sprint 7 — Department Wise Patient Ranking Report
-- ============================================================

create or alter procedure usp_toppatientsbydepatment
@topn int = 3
as
begin

-- cte stage 1: aggregate total visits per patient per department
; with visitcounts as (select p.patientid, p.patientname, dept.departmentname,
count(v.visitid) as totalvisits
from patient p
join visit v on p.patientid=v.patientid
join doctor d on v.doctorid=d.doctorid
join department dept on d.departmentid=dept.departmentid
group by p.patientid, p.patientname, dept.departmentname),

-- cte stage 2: rank patients within each department by total visits
rankedpatients as (select patientid, patientname, departmentname, totalvisits,
dense_rank() over (partition by departmentname order by totalvisits desc) as visitrank
from visitcounts)

-- final: filter only top n ranked patients per department
Select departmentname, visitrank, patientname, totalvisits
from rankedpatients
where visitrank <= @topn
order by departmentname, visitrank
end;

-- Display: top 3 patients per department (default)
exec usp_toppatientsbydepatment;

-- Display: top 5 patients per department
exec usp_toppatientsbydepatment @topn = 5;



-- ============================================================
--Sprint 8 - Doctor Hierarchy and Referral Chain
-- ============================================================

alter table doctor
add mentordoctorid int null foreign key references doctor(doctorid);

-- assign mentors
update doctor set mentordoctorid = null where doctorid = 1;  -- dr. anita sharma, top level
update doctor set mentordoctorid = 1 where doctorid = 2;     -- dr. rajesh mehta reports to anita
update doctor set mentordoctorid = 1 where doctorid = 3;     -- dr. priya nair reports to anita
update doctor set mentordoctorid = 2 where doctorid = 4;     -- dr. suresh patel reports to rajesh
update doctor set mentordoctorid = 2 where doctorid = 5;     -- dr. kavita desai reports to rajesh
update doctor set mentordoctorid = 3 where doctorid = 6;     -- dr. amit joshi reports to priya
update doctor set mentordoctorid = 3 where doctorid = 7;     -- dr. neha gupta reports to priya
update doctor set mentordoctorid = 4 where doctorid = 8;     -- dr. vikram singh reports to suresh
update doctor set mentordoctorid = 5 where doctorid = 9;     -- dr. pooja iyer reports to kavita
update doctor set mentordoctorid = 6 where doctorid = 10;    -- dr. arjun rao reports to amit
update doctor set mentordoctorid = null where doctorid = 11; -- dr. meera kapoor, top level
update doctor set mentordoctorid = 11 where doctorid = 12;   -- dr. sanjay bose reports to meera

create procedure usp_getdoctorhierarchy
@doctorname nvarchar(100) = null
as
begin
declare @sql nvarchar(2000)
set @sql = N'
; with doctorhierarchy as (select doctorid,doctorname,mentordoctorid,
0 as hierarchylevel,
cast(doctorname as nvarchar(500)) as hierarchypath
from doctor
where mentordoctorid is null
union all

-- recursive: join each doctor to their mentor
Select d.doctorid,d.doctorname,d.mentordoctorid,dh.hierarchylevel + 1,
cast(dh.hierarchypath + N'' > '' + d.doctorname as nvarchar(500))
from doctor d
join doctorhierarchy dh on d.mentordoctorid = dh.doctorid)

select hierarchylevel,doctorname,hierarchypath
from doctorhierarchy'
if @doctorname is not null
set @sql = @sql + N' where doctorname = @doctorname
or hierarchypath like N''%'' + @doctorname + N''%'''

set @sql = @sql + N' order by hierarchylevel, doctorname
option (maxrecursion 100)'

exec sp_executesql @sql,
N'@doctorname nvarchar(100)',
@doctorname = @doctorname
end;

-- display: full hierarchy of all doctors
exec usp_getdoctorhierarchy;

exec usp_getdoctorhierarchy @doctorname = 'dr. vikram singh';


--============================================================
--Sprint 9 - Staff Salary Grade and Domain Lookup
--============================================================


