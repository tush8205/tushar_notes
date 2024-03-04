

load data
CHARACTERSET UTF8
INFILE 'sam_demo.csv'
BADFILE 'sam_demo.csv_par.bad'
DISCARDFILE 'sam_demo.csv_par.dsc'
Append
INTO TABLE MIGADM.Sample_demo
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(
cust_id ,
address ,
pin_code ,
city ,
states 


)