spool Ins_COBM_DOM.log;
set time on timing on echo on;
alter session set nls_date_format='DD-MM-YYYY';



--CREATE OR REPLACE PROCEDURE MIGADM.INS_COBM_DOM
--AS
DECLARE

CURSOR C1 IS
SELECT * from migadm.pms_folio_mapp;
lv_errm VARCHAR2(200);
lv_errcode NUMBER;
v_count NUMBER;

BEGIN
FOR i in C1
LOOP
    BEGIN
v_count:=0;  
   BEGIN       
select count(1) into v_count from migadm.PMS_MASTER_REF where PRODUCT_CODE=i.SCHEME_CODE_CODE AND PRODUCT_ISSUER=i.ISSUER_ID;
    END;  
IF (v_count>0)THEN
   BEGIN 
    update migadm.pms_folio_mapp set mig_flg='Y',mig_date=sysdate  where SCHEME_CODE=i.SCHEME_CODE AND ISSUER_ID=i.ISSUER_ID ;
EXCEPTION WHEN OTHERS THEN
lv_errm := SQLERRM;
lv_errcode := SQLCODE;
insert into MIGADM.mig_err_log values ('demo_failure',lv_errcode,lv_errm,sysdate,i.SCHEME_CODE ,'record not updated');
   END;
   ELSE
update migadm.pms_folio_mapp set mig_flg='N',mig_date=sysdate  where SCHEME_CODE=i.SCHEME_CODE AND ISSUER_ID=i.ISSUER_ID ;
insert into MIGADM.mig_err_log values ('demo_failure',23345,'scheme_code and issuer_id combination not present',sysdate,i.PRODUCT_CODE,'combination not present'); 
   END IF;
END;                                                       
END LOOP;
COMMIT;
END;
/
spool off;