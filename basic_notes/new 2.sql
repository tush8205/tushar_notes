--CREATE OR REPLACE PROCEDURE MIGADM.INS_COBM_DOM
--AS
DECLARE





CURSOR C1 IS
SELECT * from migadm.customer where mig_flg is null;
lv_errm VARCHAR2(200);
lv_errcode NUMBER;
v_count NUMBER;
BEGIN
FOR i in C1
LOOP
    BEGIN
v_count:=0;  
   BEGIN       
select count(1) into v_count from migadm.employee where emp_id=i.emp_id;
    END;  
  IF (v_count>0) THEN
    BEGIN
        
    update migadm.customer set mig_flg='Y' where cust_id=i.cust_id;
	
EXCEPTION WHEN OTHERS THEN
lv_errm := SQLERRM;
lv_errcode := SQLCODE;
insert into MIGADM.mig_err_log values ('demo_failure',lv_errcode,lv_errm,sysdate,i.emp_id,'record not inserted');
   END;
ELSE
	update migadm.customer set mig_flg='N' where cust_id=i.cust_id;   
   END IF;
END;                                                       
END LOOP;
COMMIT;
END;
/