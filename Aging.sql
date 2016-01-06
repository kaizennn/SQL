set echo off
set feedback off
set heading off
set verify off
spool D:Aging.txt
/*  Aging.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/   
set lines 9999
set trimspool on
prompt
prompt ****** PURCHASE ORDER AGING Report *********
prompt
select 'Today''s Date: ',sysdate from dual;
prompt
accept vQueryDate prompt 'Please enter number of days to query: ';
set heading on
column k1 heading PO|Numb format a4 justify left
column k2 heading PO|Stat format a4 justify left
column k3 heading Date|Open justify left
column k4 heading Prod|Num format a4 justify left
column k5 heading Product|Description format a13 justify left
column k6 heading Order|Qty justify left
column k7 heading Unit|Price format 9999.99 justify left
column k8 heading Order|Amount format 9999.99 justify left
column k9 heading SNUM format a4 justify left
column k10 heading SNAME format a15
column k11 heading Days|Open format 9999 justify left
set heading on
select O# as k1, OrdStatus as k2, to_char(ODate, 'MM/DD/YYYY') as k3, ORDERS.P# as k4, PDesc as k5, OrderQty as k6, 
	PPricePaid as k7, OrderAmount as k8, SUPPLIERS.S# as k9, SName as k10, 
	(trunc(sysdate) - trunc(ODate))as k11
from ORDERS, PRODUCTS, SUPPLIERS, dual
where trunc(ODate) <= trunc(sysdate) - ('&vQueryDate')
and ORDERS.P# = PRODUCTS.P#
and ORDERS.S# = SUPPLIERS.S#
and OrdStatus = 'O'
order by k11 desc;

spool off;



