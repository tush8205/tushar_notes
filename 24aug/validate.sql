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
select count(1) into v_count from migadm.PMS_MASTER_REF where (SCHEME_CODE=i.PRODUCT_CODE AND ISSUER_ID=i.PRODUCT_ISSUER);
    END;  
IF (v_count>0)THEN
   BEGIN 
    update migadm.pms_folio_mapp set (mig_flg='Y',mig_date='sysdate')  where (SCHEME_CODE=i.PRODUCT_CODE AND ISSUER_ID=i.PRODUCT_ISSUER) ;
EXCEPTION WHEN OTHERS THEN
lv_errm := SQLERRM;
lv_errcode := SQLCODE;
insert into MIGADM.mig_err_log values ('validate_hdfc',lv_errcode,lv_errm,sysdate,i.PRODUCT_CODE AND i.PRODUCT_ISSUER,'recordnotinserted');
   END;
 END IF;
                                                       
END LOOP;
COMMIT;
END;
/