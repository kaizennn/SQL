set echo off
set feedback off
set heading off
set verify off
spool D:CreatePO.txt
/*  CreatePO.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/   

prompt
prompt ****** C R E A T E  O R D E R *********
prompt
select 'Today''s Date:', sysdate from dual;
prompt
accept vENum prompt 'Enter the Employee Number:  ';
	select '	','Employee Name:  ', initcap(EName_Last)||','||' '||initcap(EName_First) from EMPLOYEES where E# = '&vENum';
	select '	','Employee Job Title:  ',initcap(EJobTitle) from EMPLOYEES where E# = '&vENum';
prompt
accept vPNum prompt 'Enter the Item Number:  ';
	select '	','Item Description:  ', initcap(PDesc) from PRODUCTS where P# = initcap('&vPNum');
	select '	','Current Inventory Level:  ', INV from PRODUCTS where P# = initcap('&vPNum');
prompt

column SNUM format a4
column SNAME format a15
column LOCATION format a20
column UnitPrice format $99999.99

prompt Please select from one of the following Authorized Suppliers: 
set heading on
	select SUPPLIERS.S# as SNUM, SName as SNAME, initcap(City)||','||' '||+"State" as LOCATION, PPrice as UnitPrice from SUPPLIERS,PRICES where PRICES.P# = initcap('&vPNum') and PRICES.S# = SUPPLIERS.S#;
set heading off
prompt
accept vSNum prompt 'Enter the Supplier Number:  ';
	select 'Supplier Name:  ', initcap(SName) from SUPPLIERS where S# = initcap('&vSNum');
	select 'Address:  ', initcap(Address) from SUPPLIERS where S# = initcap('&vSNum');
	select 'City, State Zip:  ', initcap(City)||','||' '||"State"||' '||Zip from SUPPLIERS where S# = initcap('&vSNum');
	select 'Phone:  ', '('||substr(Phone, 1, 3)||')'||substr(Phone, 4, 3)||'-'||substr(Phone, -4) from SUPPLIERS where S# = initcap('&vSNum');
prompt
accept vOrderQty prompt 'Enter Order Quantity:  ';
	select '	','Unit Price:  ', PPrice as UnitPrice from PRICES where P# = initcap('&vPNum') and S# = initcap('&vSNum');
	select '	','Amount Ordered:  ', (PPrice * '&vOrderQty') as UnitPrice from PRICES where P# = initcap('&vPNum') and S# = initcap('&vSNum');
prompt
prompt ***** Order Status:   Open
prompt
select '***** Purchase Order number is ----->  ', maxnum from COUNTER;


insert into ORDERS (O#, ODate, E#_Order, S#, P#, PPricePaid, OrderAmount, OrderQty, OrdStatus) 
	select maxnum, sysdate,'&vENum', initcap('&vSNum'),initcap('&vPNum'), PPrice, (PPrice*'&vOrderQty'), '&vOrderQty', 'O' from COUNTER, dual, PRICES where P# = initcap('&vPNum') and S# = initcap('&vSNum');
update COUNTER set maxnum = maxnum + 1;
commit; 

spool off;



