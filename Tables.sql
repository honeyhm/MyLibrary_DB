--create database Library_DB;
--**************************************************************************************************************
use Library_DB;
--**************************************************************************************************************

create table Book
(	ISBN nvarchar(20) not null,
	Code nvarchar(20) not null,
	Title nvarchar(max) not null,
	Genre nvarchar(max),
	BookType smallint not null,
	Holding smallint default 1,
	Available bit not null default 1,
	Publisher nvarchar(max),
	Edition smallint,
	primary key(ISBN),
	Unique (Code),
	check (BookType between 1 and 3)
);

--**************************************************************************************************************

create table Library
(	Code nvarchar(20) not null,
	Name nvarchar(max),
	City nvarchar(30) not null,
	Street nvarchar(30),
	Number smallint, -- Number = Å·«ò)
	primary key(Code),
);


--**************************************************************************************************************

create table Librarian
(	Code nvarchar(20) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(100) not null,
	Active bit not null,
	PhoneNumber varchar(20) not null,
	City nvarchar(30) not null,
	Street nvarchar(30),
	Number smallint, -- Number = Å·«ò)
	primary key(Code)
);


--**************************************************************************************************************
--use Library_DB;
--ALTER TABLE Librarian DROP COLUMN Active;
--ALTER TABLE Librarian add Active bit not null;
create table Member
(	Code nvarchar(20) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(100) not null,
	MembershipDate Date not null,
	MemberType smallint not null,
	Active bit not null,
	Email varchar(max),
	PhoneNumber varchar(20) not null,
	City nvarchar(30) not null,
	Street nvarchar(30),
	Number smallint, -- Number = Å·«ò
	primary key(Code),
	check (MemberType between 1 and 3)
);


--**************************************************************************************************************

create table Author
(	ISBN_FK nvarchar(20) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(100) not null,
	constraint AuthorFK
		foreign key (ISBN_FK) references Book(ISBN),
	primary key (ISBN_FK , FirstName , LastName ),
	unique (ISBN_FK)
);

--**************************************************************************************************************

create table Translator
(	ISBN_FK nvarchar(20) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(100) not null,
	constraint TranslatorFK
		foreign key (ISBN_FK) references Book(ISBN),
	primary key (ISBN_FK , FirstName , LastName ),
	unique (ISBN_FK)
);


--**************************************************************************************************************
	
create table LibraryPhone
(	LibraryCode nvarchar(20) not null,
	PhoneNumber varchar(20) ,
	constraint LibraryPhoneFK
		foreign key (LibraryCode) references Library(Code),
	primary key (LibraryCode,PhoneNumber)
);


--**************************************************************************************************************

create table Bailment
(	ISBN_FK nvarchar(20) not null,
	LibrarianCode nvarchar(20) not null,--*******************************************6'pyfdsTRO8U
	MemberCode nvarchar(20) not null,
	StartDate Date not null,
	EndDate Date,
	constraint BailmentFK
		foreign key (ISBN_FK) references Book(ISBN),
	constraint BailmentFK2
		foreign key (LibrarianCode) references Librarian(Code),
	constraint BailmentFK3
		foreign key (MemberCode) references Member(Code),
	primary key  (ISBN_FK , LibrarianCode , MemberCode)
	--constraint BailmentCheck
		--check(not exists(select * from Member,Book where
		--(MemberType=2 and BookType=3 ) and (MemberType=3 and (BookType=1 or BookType=3))))
);


--**************************************************************************************************************

create table WorksFor
(	LibraryCode nvarchar(20) not null,
	LibrarianCode nvarchar(20) not null,
	StartWorkDate Date not null,
	EndWorkDate Date,
	foreign key (LibraryCode) references Library(Code),
	foreign key (LibrarianCode) references Librarian(Code),
	primary key(LibraryCode , LibrarianCode , StartWorkDate)
);


--**************************************************************************************************************

create table Contain
(	LibraryCode nvarchar(20) not null,
	ISBN_FK nvarchar(20) not null,
	Existance bit not null,
	EntryDate Date not null,
	constraint ContainFK
		foreign key (LibraryCode) references Library(Code),
	constraint ContainFK2
		foreign key (ISBN_FK) references Book(ISBN),
	primary key (LibraryCode , ISBN_FK)
);


--**************************************************************************************************************

create table Manager
(	Code nvarchar(20) not null,
	FirstName nvarchar(30) not null,
	LastName nvarchar(100) not null,
	Active bit not null,
	PhoneNumber varchar(20) not null,
	City nvarchar(30) not null,
	Street nvarchar(30),
	Number smallint, -- Number = Å·«ò)
	primary key(Code)
);


--**************************************************************************************************************

create table Manages
(	LibraryCode nvarchar(20) not null,
	ManagerCode nvarchar(20) not null,
	StartWorkDate Date not null,
	EndWorkDate Date,
	constraint ManagesFK
		foreign key (LibraryCode) references Library(Code),
	constraint ManagesFK2
		foreign key (ManagerCode) references Manager(Code),
	primary key(LibraryCode , ManagerCode , StartWorkDate)
);

--**************************************************************************************************************

create table UserPass
(	Username nvarchar(20) not null,
	Password nvarchar(20) not null,
	Type smallint, --Manager 1 ,Librarian 2,Member 3
	primary key(Username)

);