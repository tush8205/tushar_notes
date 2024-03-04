set serveroutput on 
declare 
var1 number;
begin
var1:=100;
for var2 in 1..10 loop
dbms_output.put_line(var1*var2);
end loop;
end;




CURSOR

declare
e_id employee.emp_id %type;
e_name employee.emp_name%type;
e_salaty employee.emp_salary%type;
CURSOR e_employee IS 
select emp_id,emp_name ,emp_salary from employee;
BEGIN
OPEN e_employee;
LOOP
FETCH e_employee intp e_id,e_name,e_salaty;
EXIT WHEN e_employee%notfound;
dbms_output.put_line(e_id||': '|| e_name||': '|| e_salary);
END LOOP;
CLOSE e_employee;
END ;

