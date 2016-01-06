spool D:setup.txt
set echo on

/* Setup.SQL 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/
	
-- Dropping of tables.
drop table ORDERS;
drop table PRICES;
drop table PRODUCTS;
drop table EMPLOYEES;
drop table SUPPLIERS;
drop table COUNTER;

-- Creation of Tables.
create table EMPLOYEES (
			E# varchar2(3) primary key,
			EName_First varchar2(20),
			EName_Last varchar2(30),
			EJobTitle varchar2(40));
			
create table SUPPLIERS (
			S# varchar2(2) primary key,
			SName varchar2(35),
			Address varchar2(40),
			City varchar2(25),
			"State" varchar2(25),
			Zip varchar2(5),
			Phone varchar2(10));
			
create table PRODUCTS (
			P# varchar2(2) primary key,
			PDesc varchar2(15),
			INV number(4));	
			
create table PRICES (
			S# varchar2(2),
			P# varchar2(2),
			PPrice number(10, 2),
			primary key (P#, S#),
			constraint fk_S# foreign key (S#) references SUPPLIERS(S#),
			constraint fk_P# foreign key (P#) references PRODUCTS(P#));
			
create table ORDERS (
			O# varchar2(4) primary key,
			ODate date,
			DeliveryDate date,
			E#_Order varchar2(3),
			E#_Receive varchar2(3),
			S# varchar2(2),
			P# varchar2(2),
			PPricePaid number(10, 2),
			OrderAmount number(10, 2),
			OrderQty number(4),
			ReceiveQty number(4),
			OrdStatus varchar2(1),
			constraint fk_E#_Order foreign key (E#_Order) references EMPLOYEES(E#),
			constraint fk_E#_Receive foreign key (E#_Receive) references EMPLOYEES(E#),	
			constraint fk_S2# foreign key (S#) references SUPPLIERS(S#),
			constraint fk_P2# foreign key (P#) references PRODUCTS(P#));
			
-- Insertion of Data.
insert into EMPLOYEES values ('101','Kanye', 'West','Inventory Specialist');
insert into EMPLOYEES values ('102','Jay', 'Z','Inventory Specialist');
insert into EMPLOYEES values ('103','Donald', 'Trump','Merchandise Specialist');
insert into EMPLOYEES values ('104','Betty', 'Crocker','Merchandise Specialist');
insert into EMPLOYEES values ('105','Stephen', 'Curry','3 Point Specialist');

insert into SUPPLIERS values ('S1','Staples','12070 Lakewood Blvd','Downey', 'CA','00000', '5628036377');
insert into SUPPLIERS values ('S2','OfficeMax','7075 Firestone Blvd','Downey', 'CA','00000', '5628066600');
insert into SUPPLIERS values ('S3','Office Depot','10710 Firestone Blvd','Norwalk', 'CA','12345', '5624068686');
insert into SUPPLIERS values ('S4','Lion Office Products Inc','401 W Alondra Blvd','Gardena', 'CA','12345', '3107198892');
insert into SUPPLIERS values ('S5','Bluebird Office Supplies','2110 Pontius Ave','Los Angeles', 'CA','54321', '8884770700');

insert into PRODUCTS values ('P1','Pencil', '200');
insert into PRODUCTS values ('P2','Marker', '220');
insert into PRODUCTS values ('P3','Folder', '400');
insert into PRODUCTS values ('P4','Stapler', '150');
insert into PRODUCTS values ('P5','Printer', '3');

insert into PRICES values ('S1','P1','2.01');
insert into PRICES values ('S1','P2','4.00');
insert into PRICES values ('S2','P1','2.50');
insert into PRICES values ('S3','P4','5.00');
insert into PRICES values ('S5','P3','3.00');

insert into ORDERS values ('1000', '22-Jul-15','29-Jul-15', '101','101', 'S1' , 'P1', '2.00','300.00', '150', '0', 'O');
insert into ORDERS values ('1001', '15-Jul-15','21-Jul-15', '102','102', 'S5' , 'P3', '3.00','450.00', '150', '0', 'O');
insert into ORDERS values ('1002', '01-Aug-15','14-Aug-15', '103','103', 'S2' , 'P1', '2.50','440.00', '200', '180', 'C');
insert into ORDERS values ('1003', '22-Jul-15','29-Jul-15', '104','102', 'S1' , 'P2', '4.00','320.00', '80', '0', 'O');
insert into ORDERS values ('1004', '31-Dec-15','3-Jan-16', '102','102', 'S3' , 'P4', '5.00', '250.00','50', '5', 'O');



-- Show of Tables to Verify.

select * from EMPLOYEES;
select * from PRODUCTS;
select * from SUPPLIERS;
select * from PRICES;
column PPrice format 99999.99 
select * from ORDERS;
column PPricePaid format 99999.99
column OrderAmount format 99999.99

-- Creation of counter table.
create table COUNTER (
			maxnum number(4));
insert into COUNTER values('1005');

select * from COUNTER;

-- Save.
commit;

spool off;


