set echo off
set feedback off
set heading off
set verify off
spool D:ShortShip.txt
/*  ShortShip.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/   
set lines 9999
set trimspool on
prompt
prompt ****** SHORT SHIP Report *********
prompt
select 'Today''s Date: ',sysdate from dual;
prompt
column k1 heading PO|Numb format a4 justify left
column k2 heading PO|Stat format a4 justify left
column k3 heading Date|Open justify left
column k4 heading Prod|Num format a4 justify left
column k5 heading Product|Description format a15 justify left
column k6 heading Order|Qty format 999999 justify left
column k7 heading Receive|Qty format 9999999 justify left
column k8 heading Short|Qty format 99999 justify left
column k9 heading SNUM format a4 justify left
column k10 heading SNAME justify left
set heading on
select O# as k1, OrdStatus as k2, to_char(ODate, 'MM/DD/YYYY') as k3, ORDERS.P# as k4, PDesc as k5, OrderQty as k6, ReceiveQty as k7, (OrderQty - ReceiveQty) as k8, SUPPLIERS.S# as k9, SName as k10
from ORDERS, PRODUCTS, SUPPLIERS
where OrderQty > ReceiveQty
and ORDERS.P# = PRODUCTS.P#
and ORDERS.S# = SUPPLIERS.S#
and OrdStatus = 'C'
order by O# asc;

spool off; 