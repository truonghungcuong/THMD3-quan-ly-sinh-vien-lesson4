create database QuanLySinhVien;
use QuanLySinhVien;
create table Class(
                      ClassID int not null auto_increment primary key,
                      ClassName varchar(60) not null,
                      StartDate datetime not null,
                      Status bit
);
insert into Class(ClassName,StartDate,Status)
    value('A1','2008-12-20',1);
insert into Class(ClassName,StartDate,Status)
    value('A2','2008-12-22',1);
insert into Class(ClassName,StartDate,Status)
    value('B3',current_date(),0);
create table Student(
                        StudentID int not null auto_increment primary key,
                        StudentName varchar(30) not null,
                        Address varchar(50),
                        Phone varchar(20),
                        Status bit,
                        ClassId int not null,
                        foreign key(ClassId) references Class(ClassID)
);
insert into Student(StudentName,Address,Phone,Status,ClassId)
    value('Hung','Ha Noi','0123456789',1,1);
insert into Student(StudentName,Address,Status,ClassId)
    value('Hoa','Hai Phong',1,1);
insert into Student(StudentName,Address,Phone,Status,ClassId)
    value('Manh','HCM','123456789',0,2);

create table Subject(
                        SubId int not null auto_increment primary key,
                        SubName varchar(30) not null,
                        Credit tinyint not null default 1 check (Credit >=1),
                        Status bit default 1
);
insert into Subject(SubName,Credit,Status)
    value('CF',5,1),
    ('C',6,1),
    ('HDJ',5,1);
create table Mark(
                     MarkId int not null auto_increment primary key,
                     SubId int not null,
                     StudentId int not null,
                     Mark float default 0 check (Mark between 0 and 100),
                     ExamTimes tinyint default 1,
                     unique(SubId,StudentId),
                     foreign key (SubId) references Subject(SubId),
                     foreign key (StudentId) references Student(StudentId)
);
insert into Mark(SubId,StudentId,Mark,ExamTimes)
    value(1,1,8,1),
    (1,2,10,2),
    (2,1,12,1);
select*from Student;
select *from mark;


select *from student
where Status=true;

select *
from subject
where Credit<10;

select S.StudentId,S.StudentName,C.ClassName
from Student S join Class C on S.ClassId=C.ClassID
where C.ClassName='A1';

select s.studentid,s.studentname,sub.subname,m.mark
from student s join mark m on s.StudentID = m.StudentId join subject sub on m.SubId = sub.SubId;

select s.studentid,s.studentname,sub.subname,m.mark
from student s join mark m on s.StudentID = m.StudentId join subject sub on m.SubId=sub.SubId
where sub.SubName='CF';

select *
from student
where StudentName like 'h%';

select *
from class
where  month(StartDate)='12';

select *
from subject
where Credit between '3' and '5';

update student
set ClassId='2'
where StudentName='hung';

select s.Studentname,sub.SubName,m.Mark
from student s join mark m on s.StudentID = m.StudentId join subject sub on m.SubId = sub.SubId
order by Mark desc , StudentName asc;

select Address, count(StudentID) as 'Số lượng sinh viên'
from student
group by Address;

select s.studentid,s.studentname,avg(Mark)
from student s join mark m on s.StudentID = m.StudentId
group by s.studentid, s.studentname;

select s.studentid,s.studentname,avg(Mark)
from student s join mark m on s.StudentID = m.StudentId
group by s.studentid, s.studentname
having avg(mark)>15;

select s.studentid,s.studentname,avg(Mark)
from student s join mark m on s.StudentID = m.StudentId
group by s.studentid, s.studentname
having avg(Mark)>= all(select avg(mark) from mark group by mark.StudentID);