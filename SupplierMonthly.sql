set echo off
set feedback off
set heading off
set verify off
spool D:SupplierMonthly.txt
/*  SupplierMonthly.sql 	*/

/*	Kevin Sattakun 
	IS 380 Section 02 
	Professor Lee		*/
	
set lines 9999
set trimspool on
prompt
prompt ****** SUPPLIER MONTHLY Report *********
prompt
column k1 heading Supplier|Number format a8 justify left
column k2 heading Supplier|Name format a12 justify left
column k3 heading Order|Month justify left
column k4 heading "No of|Orders" format 9999 justify left
column k5 heading Total|Units format 999,999 justify center
column k6 heading Total|Amount format $999,999 justify center
set heading on
select SUPPLIERS.S# as k1, SName as k2, to_char(ODate, 'MM/YYYY') as k3, count(O#) as k4, sum(OrderQty) as k5, sum(OrderAmount) as k6
from ORDERS, SUPPLIERS
where SUPPLIERS.S# = ORDERS.S#
group by SUPPLIERS.S#, SName, to_char(ODate, 'MM/YYYY')
order by SUPPLIERS.S# asc;

spool off; 