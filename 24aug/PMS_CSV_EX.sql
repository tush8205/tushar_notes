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

select * from migadm.PMS_FOLIO_MAPP;

BEGIN
fp1 := utl_file.fopen(lv_path,'PMS_FOLIO_MAPP_EX.csv','w',32767);

FOR  i in ubp_cur
LOOP
	

	lv_ubp_up := '';


	lv_ubp_up  :=  i.PAN_NUMBER || ',' ||i.FOLIO_NUMBER|| ',' ||i.SCHEME_CODE|| ',' ||i.CUSTOMER_NAME||','||i.CUSTOMER_ID||',' ||i.ISSUER_ID||','||i.ASSET_CLASS||','||i.INVESTMENT_ID ;
	
	
utl_file.put_line(fp1,lv_ubp_up);	
END loop;


utl_file.fclose_all;


END;
/
spool off;

