-- UC-1
create database Address_Book_Service
use Address_Book_Service

-- UC-2
create table Address_Book
(
	FirstName varchar(50) not null,
	LastName varchar(100) not null,
	Address varchar(200) not null,
	City varchar(50) not null,
	State varchar(80) not null,
	ZipCode int not null,
	Phone_Number bigint not null unique,
	Email varchar(200) not null unique
)
select * from Address_Book
exec sp_help 'Address_Book'

-- UC-3
Insert into Address_Book (FirstName,LastName,Address,City,State,ZipCode,Phone_Number,Email) values('Mahesh','Waghmare','Hari om Niwas, Nagoba Nagar','Ahmedpur','Maharashtra',413515,9028876133,'waghmaremahesh01223@gmail.com')
Insert into Address_Book (FirstName,LastName,Address,City,State,ZipCode,Phone_Number,Email) values('Yashwant','Kadam','Holkar Nagar','Ahmedpur','Maharashtra',413508,88562365,'yashwant15@gmail.com')
Insert into Address_Book (FirstName,LastName,Address,City,State,ZipCode,Phone_Number,Email) values('Ganesh','Kendre','Shevaneri Niwas, Sambhaji Nagar','Latur','Maharashtra',413513,8999994080,'ganeshKendre015@gmail.com')
Insert into Address_Book (FirstName,LastName,Address,City,State,ZipCode,Phone_Number,Email) values('Tushar','Garad','Aai Niwas, Patherdi','Ahmedpur','Maharashtra',413212,8996372401,'tushargarad205@gmail.com')

-- UC-4
update Address_Book set FirstName = 'Shubhanjli',LastName ='Kamble' where FirstName = 'Tushar'
update Address_Book set Email = 'shubhanjlikamble25@gmail.com',City ='Latur' where FirstName = 'Shubhanjli'

-- UC-5
delete Address_Book where FirstName = 'Shubhanjli'

-- UC-6
Select * from Address_Book where city = 'Ahmedpur' or  State = 'Maharashtra'
Select * from Address_Book where city = 'Ahmedpur' and  State = 'Maharashtra'

-- UC-7 
Select Count(*) As Size from Address_Book where city = 'Ahmedpur' or  State = 'Maharashtra'
Select Count(*) As Size from Address_Book where city = 'Ahmedpur' and  State = 'Maharashtra'

-- UC-8
Select * from Address_Book where City = 'Ahmedpur' Order By FirstName asc;

-- UC-9
ALTER TABLE Address_Book ADD AdressBookName varchar(50), Type varchar(20);

UPDATE  Address_Book SET AdressBookName='FamilyAddressBook' , Type = 'Family' WHERE FirstName ='Mahesh' or FirstName='Shubhanjli';
UPDATE  Address_Book SET AdressBookName='FriendAddressBook' , Type = 'Friend' WHERE FirstName ='Yashwant' or FirstName='Ganesh';
UPDATE  Address_Book SET AdressBookName='ProfessionAddressBook' , Type = 'profession' WHERE FirstName ='Tushar';

-- UC-10
Select COUNT(*) as Size,Type from Address_Book group by Type;
Select count(*)as CountAbNames, AdressBookName  from Address_Book group by AdressBookName;

-- UC-11
Insert into Address_Book (FirstName,LastName,Address,City,State,ZipCode,Phone_Number,Email,AdressBookName,Type) values('Yashwant','Kadam','Holkar Nagar','Ahmedpur','Maharashtra',413508,88562365122,'yashwant15255@gmail.com','FamilyAddressBook','Family')
select * from Address_Book

-- UC-12
--Create AddressBook Table
CREATE TABLE AddressBook(
	AddressBookId INT IDENTITY(1,1) PRIMARY KEY,
	AddressBookName VARCHAR(30)
);
--Create Persons Table
CREATE TABLE PersonTypes(
	PersonTypeId INT IDENTITY(1,1) PRIMARY KEY,
	PersonType varchar(50),
	--PersonId INT  FOREIGN KEY REFERENCES Person(PersonId)
);

--Create Table Persons
CREATE TABLE Person(
	PersonId INT IDENTITY(1,1) PRIMARY KEY,
	AddressBookId INT FOREIGN KEY REFERENCES AddressBook(AddressBookId),
	FirstName varchar(30),
	LastName varchar(30),
	Address varchar(30),
	City varchar(30),
	StateName varchar(30),
	ZipCode int,
	PhoneNumber bigint,
	EmailId varchar(30)
);

CREATE TABLE PersonTypesMap(
	PersonId INT FOREIGN KEY REFERENCES Person(PersonId),
	PersonTypeId INT FOREIGN KEY REFERENCES PersonTypes(PersonTypeId)
);

--Insert Values into address books
INSERT INTO AddressBook VALUES ('Mahesh'),('Shubhanjli');
SELECT * FROM AddressBook;

--Insert values in persons type
INSERT INTO PersonTypes VALUES ('Family'),('Friend'),('Profession');
SELECT * FROM PersonTypes;

---Insert Values into Persons
INSERT INTO Person VALUES (1,'Shubhanjli','Kamble','Bhim Nagar','Latur','Maharashtra',600062,9876543210,'Shubhanjlikamble125@gmail.com');
INSERT INTO Person VALUES (1,'Ganesh','Kendre','Shivaneri Niwas','Latur','Maharashtra',602536,9985543210,'GaneshKendre007@gmail.com'),(2,'Shubhangi','Mote','Motegaon','Osmanabad','Maharashtra',674536,9985595210,'ShubhangiMote@gmail.com');
INSERT INTO Person VALUES (1,'Avinash','Fadatale','Lohara','Solapur','Kerala',602536,9985543210,'AvinashFadatale1588@gmail.com');
SELECT * FROM Person;

--Insert into persons type map tables
INSERT INTO PersonTypesMap VALUES (1,1),(2,2),(3,3),(4,1);
SELECT * FROM PersonTypesMap;

--Retrive All Data---
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId FROM
AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId;

-- UC-13
--Retrieve based on city and state--
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId FROM
AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId AND (p.City='Latur' OR p.StateName='Maharashtra')
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId;

--Count based on city---
Select Count(*) As Count,StateName,City from Person group by StateName,City;

--Sort based on first name
SELECT ab.AddressBookId,ab.AddressBookName,p.PersonId,p.FirstName,p.LastName,p.Address,p.City,p.StateName,p.ZipCode,
p.PhoneNumber,p.EmailId,pt.PersonType,pt.PersonTypeId FROM
AddressBook AS ab 
INNER JOIN Person AS p ON ab.AddressBookId = p.AddressBookId
INNER JOIN PersonTypesMap as ptm On ptm.PersonId = p.PersonId
INNER JOIN PersonTypes AS pt ON pt.PersonTypeId = ptm.PersonTypeId ORDER BY p.FirstName asc;

--Retreive based on person types---
SELECT COUNT(ptm.PersonTypeId) as Relations,pt.PersonType FROM
PersonTypesMap AS ptm 
INNER JOIN PersonTypes as pt On pt.PersonTypeId = ptm.PersonTypeId
INNER JOIN Person as p ON p.PersonId = ptm.PersonId GROUP BY Ptm.PersonTypeId,pt.PersonType;