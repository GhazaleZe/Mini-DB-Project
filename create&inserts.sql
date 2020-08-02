use BankProject
go

create table Customer(
	CID int Primary Key,
	[Name] varchar(30),
	NatCod varchar(10),
	Birthdate Date,
	[Add] varchar(100),
	Tel varchar(12)
);

create Table Branch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(30),
    Branch_Addr VARCHAR(200),
    Branch_Tel VARCHAR(12),
)



create table Trn_Src_Des(
	 VoucherId varchar(10) Primary Key,
	 TrnDate date,
	 TrnTime varchar(6),
     Amount BIGINT,
     SourceDep INT,
     DesDep INT,
     Branch_ID INT,
     Trn_Desc VARCHAR(150),
     FOREIGN KEY (Branch_ID) references Branch(Branch_ID) 
);



create Table Deposit_Type (
    Dep_Type INT,
    Dep_Typ_Desc VARCHAR(100),
    PRIMARY KEY(Dep_Type)
);

create Table Deposit_Status (
    [Status] INT PRIMARY KEY,
    Status_Desc VARCHAR(100)
)

create table Deposit (
    Dep_ID INT PRIMARY KEY,
    Dep_Type INT,
    CID INT,
    OpenDate DATE,
    [Status] INT,
    FOREIGN KEY (Dep_Type) references Deposit_Type(Dep_Type), 
    FOREIGN KEY (CID) references Customer(CID),
    FOREIGN KEY (Status) references Deposit_Status([Status]),
);


select * from Customer;

INSERT INTO Customer VALUES (1,'Hasti Moheb','6660163549','1377-06-19','Esfahan','03111111110');
INSERT INTO Customer VALUES (2,'Hiva Javid','0068960379','1370-7-25','Esfahan','03122222220');
INSERT INTO Customer VALUES (3,'Ali Yasi','650716205','1375-12-05','Esfahan','03133333330');
INSERT INTO Customer VALUES (4,'Yeki Unyeki','0637753832','1378-04-09','Esfahan','03144444440');
INSERT INTO Customer VALUES (5,'Ghazale Zehtab','0480231079','1345-05-21','Esfahan','03155555550');
INSERT INTO Customer VALUES (6,'Ramin Yari','1284922121','1354-08-15','Esfahan','03179784350');
INSERT INTO Customer VALUES (7,'Mojgan Behrooz','67062571','1381-09-26','Tehran','02166775390');
INSERT INTO Customer VALUES (8,'Jila Jial ','0719583293','1369-11-13','Tehran','02188994450');
INSERT INTO Customer VALUES (9,'Elnaz Rahmati','4889483683','1378-04-18','Tehran','021883320');
INSERT INTO Customer VALUES (10,'Python SQL','1370372868','1379-03-05','Tehran','02188334450');
INSERT INTO Customer VALUES (11,'Java Cplus','4120128431','1341-09-12','Tehran','02188445560');
INSERT INTO Customer VALUES (12,'mmm mmm','0128431','1348-03-12','Tehran','02188405560');


select * from Trn_Src_Des


INSERT INTO Trn_Src_Des VALUES ('1000','1398-11-01','100101',19,701,100,102,'others to A ')
INSERT INTO Trn_Src_Des VALUES ('1003','1398-12-20','100101',65,999,101,102,'cash to B ')
INSERT INTO Trn_Src_Des VALUES ('1002','1398-12-11','100101',20,999,102,101,'cash to X ')

INSERT INTO Trn_Src_Des VALUES ('1001','1398-12-01','100101',20,100,102,102,' A to X ')
INSERT INTO Trn_Src_Des VALUES ('1004','1398-12-21','110101',60,101,102,100,' B to X ')

INSERT INTO Trn_Src_Des VALUES ('1005','1399-01-01','110101',100,102,103,101,'X to Y ')

INSERT INTO Trn_Src_Des VALUES ('1006','1399-01-02','110101',100,103,104,101,' Y to Q')
INSERT INTO Trn_Src_Des VALUES ('1007','1399-01-02','110102',40,103,105,101,'Y to S ')
INSERT INTO Trn_Src_Des VALUES ('1008','1399-01-02','110103',50,103,106,101,'Y to T ')
INSERT INTO Trn_Src_Des VALUES ('1009','1399-01-03','110101',20,103,107,102,'Y to U ')
INSERT INTO Trn_Src_Des VALUES ('1010','1399-01-03','110101',30,106,108,101,'T to Z ')

INSERT INTO Trn_Src_Des VALUES ('1011','1399-01-03','110102',25,106,730,100,'T to others ')

INSERT INTO Trn_Src_Des VALUES ('1014','1399-01-04','110101',30,108,999,100,'Z to Cash ')

INSERT INTO Trn_Src_Des VALUES ('1012','1399-01-03','110102',40,103,109,102,'Y to V ')
INSERT INTO Trn_Src_Des VALUES ('1013','1399-01-03','110103',100,103,110,101,'Y to W ')

delete from Trn_Src_Des

select * from Branch

INSERT INTO Branch VALUES ('100','Sharyati','Esfahan','03133447788')
INSERT INTO Branch VALUES ('101','Enghelab','Esfahan','03133447668')
INSERT INTO Branch VALUES ('102','Sadr','Esfahan','03133445568')

select * from Deposit_Type

insert into Deposit_Type values(1,'Type1')
insert into Deposit_Type values(2,'Type2')
insert into Deposit_Type values(3,'Type3')


select * from Deposit_Status

insert into  Deposit_Status values(1,'Status1')
insert into  Deposit_Status values(2,'Status2')
insert into  Deposit_Status values(3,'Status3')
insert into  Deposit_Status values(4,'Status4')

select * from Deposit 

insert into Deposit values(100,1,1,'1397-09-13',1)
insert into Deposit values(101,1,2,'1397-08-13',3)
insert into Deposit values(102,1,3,'1397-11-13',3)

insert into Deposit values(103,2,4,'1397-08-13',3)
insert into Deposit values(104,2,5,'1397-11-13',2)
insert into Deposit values(105,1,6,'1397-12-14',2)
insert into Deposit values(106,1,7,'1397-12-15',3)
insert into Deposit values(107,3,8,'1397-12-16',2)
insert into Deposit values(108,1,9,'1397-12-17',3)
insert into Deposit values(109,1,10,'1397-12-18',3)
insert into Deposit values(110,1,11,'1398-01-17',3)