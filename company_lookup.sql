SET VERIFY OFF;
SET HEADING OFF;
prompt 
prompt *---Customer Lookup---*
prompt 

accept vID prompt 'Please enter customer ID: ';
prompt
prompt 'Thank you!'
prompt

select 'Company Name: ' || customer_company
from customer
where  customer_id = '&vID';

select 'Contact: ' || customer_contact
from customer
where  customer_id = '&vID';

select 'Phone: ' || '(' || SUBSTR(customer_phone,1,3) || ') ' || SUBSTR(customer_phone,4,3) || '-' || SUBSTR(customer_phone,7,4)
from customer
where  customer_id = '&vID';

select 'Address: ' ||  customer_address || ' ' || customer_city || ', ' || customer_state || ' ' || customer_zip
from customer
where  customer_id = '&vID';