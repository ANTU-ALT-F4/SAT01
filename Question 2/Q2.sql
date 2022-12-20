-- Câu 1:
create database ProjectManagement
go
use ProjectManagement
go
--Câu 2:

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECT') and o.name = 'FK_PROJECT_INSTRUCT_TEACHER')
alter table PROJECT
   drop constraint FK_PROJECT_INSTRUCT_TEACHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('STUDENT') and o.name = 'FK_STUDENT_JOIN_PROJECT')
alter table STUDENT
   drop constraint FK_STUDENT_JOIN_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('STUDENT') and o.name = 'FK_STUDENT_LEARN_COURSE')
alter table STUDENT
   drop constraint FK_STUDENT_LEARN_COURSE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TEACHER') and o.name = 'FK_TEACHER_WORK_AT_WORK_UNI')
alter table TEACHER
   drop constraint FK_TEACHER_WORK_AT_WORK_UNI
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COURSE')
            and   type = 'U')
   drop table COURSE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECT')
            and   name  = 'INSTRUCT_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECT.INSTRUCT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('STUDENT')
            and   name  = 'LEARN_FK'
            and   indid > 0
            and   indid < 255)
   drop index STUDENT.LEARN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('STUDENT')
            and   name  = 'JOIN_FK'
            and   indid > 0
            and   indid < 255)
   drop index STUDENT.JOIN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('STUDENT')
            and   type = 'U')
   drop table STUDENT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TEACHER')
            and   name  = 'WORK_AT_FK'
            and   indid > 0
            and   indid < 255)
   drop index TEACHER.WORK_AT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TEACHER')
            and   type = 'U')
   drop table TEACHER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('WORK_UNIT')
            and   type = 'U')
   drop table WORK_UNIT
go

/*==============================================================*/
/* Table: COURSE                                                */
/*==============================================================*/
create table COURSE (
   CODE_COURSE          varchar(10)          not null,
   NAME                 varchar(50)          null,
   START_DAY            datetime             null,
   END_DAY              datetime             null,
   constraint PK_COURSE primary key (CODE_COURSE)
)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   CODE_PROJECT         varchar(10)          not null,
   CODE_TEACHEAR        char(10)             not null,
   NAME                 varchar(50)          null,
   TIME                 int                  null,
   constraint PK_PROJECT primary key (CODE_PROJECT)
)
go

/*==============================================================*/
/* Index: INSTRUCT_FK                                           */
/*==============================================================*/




create nonclustered index INSTRUCT_FK on PROJECT (CODE_TEACHEAR ASC)
go

/*==============================================================*/
/* Table: STUDENT                                               */
/*==============================================================*/
create table STUDENT (
   CODE_STUDENT         varchar(10)          not null,
   CODE_COURSE          varchar(10)          not null,
   CODE_PROJECT         varchar(10)          not null,
   NAME                 varchar(50)          null,
   PHONE                varchar(10)          null,
   ADDRESS              varchar(150)         null,
   constraint PK_STUDENT primary key (CODE_STUDENT)
)
go

/*==============================================================*/
/* Index: JOIN_FK                                               */
/*==============================================================*/




create nonclustered index JOIN_FK on STUDENT (CODE_PROJECT ASC)
go

/*==============================================================*/
/* Index: LEARN_FK                                              */
/*==============================================================*/




create nonclustered index LEARN_FK on STUDENT (CODE_COURSE ASC)
go

/*==============================================================*/
/* Table: TEACHER                                               */
/*==============================================================*/
create table TEACHER (
   CODE_TEACHEAR        char(10)             not null,
   CODE_WORK_UNIT       varchar(10)          not null,
   NAME                 varchar(50)          null,
   PHONE                varchar(10)          null,
   constraint PK_TEACHER primary key (CODE_TEACHEAR)
)
go

/*==============================================================*/
/* Index: WORK_AT_FK                                            */
/*==============================================================*/




create nonclustered index WORK_AT_FK on TEACHER (CODE_WORK_UNIT ASC)
go

/*==============================================================*/
/* Table: WORK_UNIT                                             */
/*==============================================================*/
create table WORK_UNIT (
   CODE_WORK_UNIT       varchar(10)          not null,
   NAME                 varchar(50)          null,
   LOCATION             varchar(50)          null,
   constraint PK_WORK_UNIT primary key (CODE_WORK_UNIT)
)
go

alter table PROJECT
   add constraint FK_PROJECT_INSTRUCT_TEACHER foreign key (CODE_TEACHEAR)
      references TEACHER (CODE_TEACHEAR)
go

alter table STUDENT
   add constraint FK_STUDENT_JOIN_PROJECT foreign key (CODE_PROJECT)
      references PROJECT (CODE_PROJECT)
go

alter table STUDENT
   add constraint FK_STUDENT_LEARN_COURSE foreign key (CODE_COURSE)
      references COURSE (CODE_COURSE)
go

alter table TEACHER
   add constraint FK_TEACHER_WORK_AT_WORK_UNI foreign key (CODE_WORK_UNIT)
      references WORK_UNIT (CODE_WORK_UNIT)
go


-- Câu 3:
INSERT INTO COURSE (CODE_COURSE, NAME, START_DAY, END_DAY) VALUES ('c1','bt1','2022-12-20','2022-12-20')
INSERT INTO COURSE (CODE_COURSE, NAME, START_DAY, END_DAY) VALUES ('c2','bt2','2022-12-20','2022-12-20')
INSERT INTO COURSE (CODE_COURSE, NAME, START_DAY, END_DAY) VALUES ('c3','bt3','2022-12-20','2022-12-20')
INSERT INTO COURSE (CODE_COURSE, NAME, START_DAY, END_DAY) VALUES ('c4','bt4','2022-12-20','2022-12-20')
SELECT * FROM COURSE

INSERT INTO WORK_UNIT (CODE_WORK_UNIT, NAME, LOCATION) VALUES ('w1','FIT','Nha C')
INSERT INTO WORK_UNIT (CODE_WORK_UNIT, NAME, LOCATION) VALUES ('w2','Khoa CNTT','Nha A')
INSERT INTO WORK_UNIT (CODE_WORK_UNIT, NAME, LOCATION) VALUES ('w3','Khoa LUAT','Nha B')
INSERT INTO WORK_UNIT (CODE_WORK_UNIT, NAME, LOCATION) VALUES ('w4','Khoa Du Lich','Nha F')
SELECT * FROM WORK_UNIT

INSERT INTO TEACHER (CODE_TEACHEAR, CODE_WORK_UNIT, NAME, PHONE) VALUES ('t1','w1','Nguyen Van A','01234567')
INSERT INTO TEACHER (CODE_TEACHEAR, CODE_WORK_UNIT, NAME, PHONE) VALUES ('t2','w2','Nguyen Van B','01234568')
INSERT INTO TEACHER (CODE_TEACHEAR, CODE_WORK_UNIT, NAME, PHONE) VALUES ('t3','w3','Nguyen Van C','01234569')
INSERT INTO TEACHER (CODE_TEACHEAR, CODE_WORK_UNIT, NAME, PHONE) VALUES ('t4','w4','Nguyen Van D','01234560')
SELECT * FROM TEACHER

INSERT INTO PROJECT (CODE_PROJECT, CODE_TEACHEAR, NAME, TIME) VALUES ('p1','t1','thiknn','60')
INSERT INTO PROJECT (CODE_PROJECT, CODE_TEACHEAR, NAME, TIME) VALUES ('p2','t2','thiknn','60')
INSERT INTO PROJECT (CODE_PROJECT, CODE_TEACHEAR, NAME, TIME) VALUES ('p3','t3','thiknn','60')
INSERT INTO PROJECT (CODE_PROJECT, CODE_TEACHEAR, NAME, TIME) VALUES ('p4','t4','thiknn','60')
SELECT * FROM PROJECT

INSERT INTO STUDENT (CODE_STUDENT, CODE_COURSE, CODE_PROJECT, NAME, PHONE, ADDRESS) VALUES ('s1','c1','p1','Nguyen Thi A','0848741314','Vinh Long')
INSERT INTO STUDENT (CODE_STUDENT, CODE_COURSE, CODE_PROJECT, NAME, PHONE, ADDRESS) VALUES ('s2','c2','p2','Nguyen Thi B','0848741324','Vinh Long')
INSERT INTO STUDENT (CODE_STUDENT, CODE_COURSE, CODE_PROJECT, NAME, PHONE, ADDRESS) VALUES ('s3','c3','p3','Nguyen Thi C','0848741334','Can Tho')
INSERT INTO STUDENT (CODE_STUDENT, CODE_COURSE, CODE_PROJECT, NAME, PHONE, ADDRESS) VALUES ('s4','c4','p4','Nguyen Thi D','0848741344','Can Tho')
SELECT * FROM STUDENT

-------------------------------------------------
SELECT * FROM COURSE
SELECT * FROM WORK_UNIT
SELECT * FROM TEACHER
SELECT * FROM PROJECT
SELECT * FROM STUDENT


-- Câu 4:
-- Cách 1:
SELECT STUDENT.CODE_STUDENT, STUDENT.NAME AS NameStudent, PROJECT.NAME AS NameProject
FROM     PROJECT INNER JOIN
                  STUDENT ON PROJECT.CODE_PROJECT = STUDENT.CODE_PROJECT
-- Cách 2:
select STUDENT.CODE_STUDENT,STUDENT.NAME,PROJECT.NAME  FROM STUDENT,PROJECT WHERE PROJECT.CODE_PROJECT = STUDENT.CODE_PROJECT

-- Câu 5:

create view teacher_v1
	as
	SELECT TEACHER.CODE_TEACHEAR,TEACHER.PHONE,TEACHER.NAME,TEACHER.CODE_WORK_UNIT 
	FROM TEACHER,WORK_UNIT 
	WHERE TEACHER.CODE_WORK_UNIT = WORK_UNIT.CODE_WORK_UNIT 
	AND WORK_UNIT.NAME LIKE 'FIT'

select * from teacher_v1 order by CODE_TEACHEAR asc

--Câu 6:
create proc add_student3(
   @CODE_STUDENT varchar(10),
   @CODE_COURSE  varchar(10),
   @CODE_PROJECT varchar(10),
   @NAME         varchar(50),
   @PHONE        varchar(10),
   @ADDRESS      varchar(150)
)
as
	if not exists(select STUDENT.CODE_STUDENT from STUDENT where CODE_STUDENT = @CODE_STUDENT)
	INSERT INTO STUDENT (CODE_STUDENT, CODE_COURSE, CODE_PROJECT, NAME, PHONE, ADDRESS) 
	VALUES (@CODE_STUDENT,@CODE_COURSE,@CODE_PROJECT,@NAME,@PHONE,@ADDRESS)
	else print (N'Đã Tồn Tại Mã Sinh Viên '+@CODE_STUDENT+ N' Này Rồi')

	SELECT * FROM STUDENT


	Exec add_student3 's6','c4','p4','Vo Huy Khang','0848741399','Long Ho'
