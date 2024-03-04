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
lv_address    varchar(20)   :='';
cursor ubp_cur is

select * from migadm.customer where mig_flg = 'Y';

BEGIN
fp1 := utl_file.fopen(lv_path,'demo_15.csv','w',32767);

FOR  i in ubp_cur
LOOP
	
 select address into lv_address  from migadm.employee where emp_id =i.emp_id;
	lv_ubp_up := '';


	lv_ubp_up  :=  rpad(nvl(i.emp_id,' '),5,' ')  || rpad(nvl(i.cust_id,' '),5,' ') || rpad(nvl(i.cust_first_name,' '),20,' ') || rpad(nvl(i.cust_last_name,' '),20,' ') || rpad(nvl(i.cust_phoneNum,' '),15,' ') || rpad(nvl(to_char(i.cust_age),' '),2,' ')  || rpad(nvl(i.cust_current_status,' '),15,' ' ) || rpad(nvl(lv_address,' '),20,' ');
	
	
utl_file.put_line(fp1,lv_ubp_up);	
END loop;


utl_file.fclose_all;


END;
/
spool off;

