set echo off
set feedback off
set heading off
set verify off
spool D:ReceivePO.txt
/*  ReceivePO.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/   

prompt
prompt ****** R E C E I V E   O R D E R *********
prompt
column MONEY format $99999.99
select 'Today''s Date: ',sysdate from dual;
prompt
accept vENum prompt 'Enter the Employee Number:  ';
	select '	','Employee Name:  ', initcap(EName_Last)||','||' '||initcap(EName_First) from EMPLOYEES where E# = '&vENum';
	select '	','Employee Job Title:  ',initcap(EJobTitle) from EMPLOYEES where E# = '&vENum';
prompt
accept vONum prompt 'Please enter the Purchase Order Number:  ';
prompt
select 'Order Number: ', O# from ORDERS where O# = '&vONum';
select 'Item Number: ', initcap(P#) from ORDERS where O# = '&vONum';
select '	','Item Description: ', PDesc from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum';
select 'Supplier Number: ', S# from ORDERS where O# = '&vONum';
select '	','Supplier Name: ', SName from SUPPLIERS, ORDERS where O# = '&vONum' and ORDERS.S# = SUPPLIERS.S#;
select 'Date ordered: ', ODate from ORDERS where O# = '&vONum';
select 'Today''s Date: ',sysdate from dual;
select 'Quantity Ordered: ', OrderQty from ORDERS where O# = '&vONum';
select 'Unit Price: ', PPricePaid as MONEY from ORDERS where O# = '&vONum';
select 'Amount Ordered: ', OrderAmount as MONEY from ORDERS where O# = '&vONum';
prompt
accept vOrderReceive prompt 'Enter quantity received: ';
select 'Amount Due: ', PPricePaid*'&vOrderReceive' as MONEY from ORDERS where O# = '&vONum';   
select 'Inventory Level: ', INV + '&vOrderReceive' from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum';
update ORDERS set DeliveryDate = (select sysdate from dual) where O# = '&vONum';
update ORDERS set E#_Receive = '&vENum' where O# = '&vONum';
update ORDERS set ReceiveQty = '&vOrderReceive' where O# = '&vONum';
prompt
prompt *****************************************************************
prompt Order is now ---> Closed
select 'Date Closed: ', sysdate from dual;

-- Updating Relevant Tables
update PRODUCTS set INV = ((select INV from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum') + '&vOrderReceive') where P# = (select ORDERS.P# from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum');
update ORDERS set OrdStatus = 'C' where O# = '&vONum';

commit;

spool off;



