spool Sample_demo.log;
set time on timing on echo on;
drop table MIGADM.Sample_demo;
CREATE TABLE MIGADM.Sample_demo(
cust_id varchar(20),
address varchar(30),
pin_code varchar(10),
city varchar(20),
states varchar(20)
);
spool off;

