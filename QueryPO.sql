set echo off
set feedback off
set heading off
set verify off
spool D:QueryPO.txt
/*  QueryPO.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/   

prompt
prompt ****** Q U E R Y  O R D E R *********
prompt
accept vONum prompt 'Please enter the Purchase Order Number:  ';
prompt
select 'Purchase Order Number: ', O# from ORDERS where O# = '&vONum';
select 'Item Number: ', initcap(P#) from ORDERS where O# = '&vONum';
select '	','Item Description: ', PDesc from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum';
select '	','Current Inventory Level: ', INV from PRODUCTS, ORDERS where PRODUCTS.P# = ORDERS.P# and O# = '&vONum';
select 'Supplier Number: ', S# from ORDERS where O# = '&vONum';
select '	','Supplier Name: ', SName from SUPPLIERS, ORDERS where O# = '&vONum' and ORDERS.S# = SUPPLIERS.S#;
prompt
column MONEY format $99999.99
select 'Date Ordered: ', ODate from ORDERS where O# = '&vONum';
select 'Quantity Ordered: ', OrderQty from ORDERS where O# = '&vONum';
select 'Date Received: ', DeliveryDate from ORDERS where O# = '&vONum';
select 'Quantity Received: ', ReceiveQty from ORDERS where O# = '&vONum';
select 'Unit Price: ', PPricePaid as MONEY from ORDERS where O# = '&vONum';
select 'Amount Ordered: ', OrderAmount as MONEY from ORDERS where O# = '&vONum';
select 'Amount Due: ', ReceiveQty * PPricePaid as MONEY from ORDERS where O# = '&vONum';
prompt
select 'Order Status: ', OrdStatus from ORDERS where O# = '&vONum';

spool off;



