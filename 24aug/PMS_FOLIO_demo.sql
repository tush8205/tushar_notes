spool PMS_FOLIO_MAPP.log;
set time on timing on echo on;
drop table MIGADM.PMS_FOLIO_MAPP;
CREATE TABLE MIGADM.PMS_FOLIO_MAPP(
PAN_NUMBER VARCHAR(25),
FOLIO_NUMBER  VARCHAR(20) NOT NULL,
SCHEME_CODE	VARCHAR(16)   NOT NULL,
CUSTOMER_NAME VARCHAR(100),
CUSTOMER_ID	VARCHAR(16) NOT NULL,
ISSUER_ID	VARCHAR(9) NOT NULL,
OPERATION	CHAR(1) NOT NULL,
ASSET_CLASS	CHAR(1) NOT NULL,
INVESTMENT_ID	VARCHAR(50),
MIG_FLG CHAR(1),
MIG_DATE DATE );
spool off;

