SET VERIFY OFF;
SET HEADING OFF;
prompt 
prompt *---Employee Lookup---*
prompt 

accept vID prompt 'Please enter employee ID: ';
prompt
prompt 'Thank you!'
prompt

select 'Name: ' || employee_lname || ', ' || employee_fname
from employee 
where  employee_id = '&vID';

select 'Phone: ' || '(' || SUBSTR(employee_phone,1,3) || ') ' || SUBSTR(employee_phone,4,3) || '-' || SUBSTR(employee_phone,7,4)
from employee
where employee_id = '&vID';

select 'Address: ' ||  employee_address || ' ' || employee_city || ', ' || employee_state || ' ' || employee_zip
from employee
where employee_id = '&vID';

select 'Date of Hire: ' || employee_hireDate
from employee
where employee_id = '&vID';

select c.customer_company as "Assigned Customers"
from employee e, customer c
where e.employee_id = c.employee_id AND e.employee_id = '&vID';