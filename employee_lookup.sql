 
prompt 
prompt *---Employee Lookup---*
prompt 

accept vID prompt 'Please enter employee ID: ';
prompt
prompt 'Thank you!'
prompt

select 'Name: ', employee_lname || ", " || employee_fname
from employee 
where  employee_id = '&vID';

select 'Phone: ', employee_phone,
from employee
where employee_id = '&vID';

select 'Address: ',  employee_address || " " || employee_city || ", " || employee_state || " " || employee_zip, 
from employee
where employee_id = '&vID';

select 'Date of Hire:', employee_hiredate
from employee
where employee_id = '&vID'

select c.customer_company as "Assigned Customers"
from employee e, company c
where e.employee_id = c.employee_id
having e.employee_id = '&vID'


