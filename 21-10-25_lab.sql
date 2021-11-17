-- drop database dgu;
show databases;
create database dgu;
show databases;
use dgu;

create table department(
	dept_id int not null primary key,
    name varchar(255) not null 
    );

show tables;

create table professor(
	prof_id int not null primary key,
    name varchar(255) not null,
    age int,
    dept_id int not null,
    
    foreign key (dept_id) references department (dept_id)
    );
    
show tables;
desc professor;
    
create table student(
    stu_id int not null primary key,
    name varchar(100) not null,
    age int, 
    student_num varchar(10),
    sex char(1),
    dept_id int not null,
    
    foreign key (dept_id) references department (dept_id)
    );
    
show tables;

create table class (
	class_id int not null primary key auto_increment, 
    name varchar(100), 
    prof_id int not null,
    
    foreign key(prof_id) references professor (prof_id)
    );
    
show tables;
    
create table enrollment(
	enrollment_id int not null primary key auto_increment,
    class_id int not null,
    stud_id int not null,
    
    foreign key (class_id) references class (class_id), 
    foreign key (stud_id) references student (stud_id)
    );
    
show tables;

desc department;
-- insert data
insert into department values(1, "information-engineeering");

select * from department;

desc professor;
insert into professor values(1, "changwhan Lee", 100, 1);

select * from professor;

desc class;
insert into class (name, prof_id) values ("database system", 1);
insert into class (name, prof_id) values ("machine learning", 1);

select * from class;

desc student;
insert into student values(1, "jungmu park", 24, "2017112227", "0", 1);
insert into student values(2, "donald park", 24, "2017112228", "0", 1);

select * from studnet;

desc enrollment;
insert into enrollment values(1, 2, 1);
insert into enrollment values(2, 2, 1);

select * from enrollment;

select * from enrollment
join class on class.class_id = enrollment.class_id
join student on enrollment.stud_id = student.stud_id;

select enrollment.enrollment_id, class.name as class_name, student.name as stud_name
from enrollment
join class on class.class_id = enrollment.class_id
join student on enrollment.stud_id = student.stud_id;


alter table class add column semester int;
desc class;

alter table class modify column name varchar(50) not null;
desc class;

alter table class change column name class_name varchar(50) not null;
desc class;

alter table class add column etc int;
desc class;

alter table class drop column etc;
desc class;

-- delete table
create table test(
	test_id int not null primary key auto_increment,
	name char(10)
    );

show tables;
drop table test;
show tables;

desc professor;
insert into professor values (2, "jeff dean", 53, 1);
insert into professor values (3, "guido van rossom", 65, 1);
insert into professor values (4, "andrew ng", 45, 1);

select * from professor;

desc class;
insert into class (class_name, prof_id, semester) values ("python", 3, 1);
insert into class (class_name, prof_id, semester) values ("artificial inteligence", 4, 1);

select * from class;

select * from student;
desc enrollment;
insert into enrollment (class_id, stud_id) values(3, 1);
insert into enrollment (class_id, stud_id) values(4, 1);

select * from enrollment;

update enrollment
set class_id = 1, stud_id = 1
where enrollment_id = 1;

select * from enrollment;

update enrollment
set class_id = 2, stud_id = 2
where enrollment_id = 2;

select * from enrollment;

-- delete data
delete from enrollment
where enrollment_id = 2;

select * from enrollment;

drop table enrollment;
show tables;
