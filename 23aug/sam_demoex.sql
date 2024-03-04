set time on timing on echo on
spool extractingfile.log

set serverout on size 1000000  echo on feedback on
set lines 10000 pages 0 trims on termout on
alter session set nls_date_format='dd-mm-yyyy';


--create or replace procedure migadm.bonds as
declare

lv_path         varchar(100) := 'MIG';
fp1             utl_file.file_type;
lv_ubp_up    varchar(8000)  :='';
lv_ubm_up1    varchar(8000)  :='';
lv_ubm_up2    varchar(8000)  :='';

cursor ubp_cur is

select * from migadm.Sample_demo;

BEGIN
fp1 := utl_file.fopen(lv_path,'demo_16.csv','w',32767);

FOR  i in ubp_cur
LOOP
	
	lv_ubp_up := '';


	lv_ubp_up  :=  rpad(nvl(i.cust_id,' '),5,' ')  || rpad(nvl(i.address,' '),50,' ') || rpad(nvl(i.pin_code,' '),15,' ') || rpad(nvl(i.city,' '),10,' ') || rpad(nvl(i.states,' '),20,' ') ;
	
	
utl_file.put_line(fp1,lv_ubp_up);	
END loop;


utl_file.fclose_all;


END;
/
spool off;

