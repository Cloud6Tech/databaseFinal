 
prompt 
prompt *---Customer Lookup---*
prompt 

accept vID prompt 'Please enter customer ID: ';
prompt
prompt 'Thank you!'
prompt

select 'Company Name: ', customer_company
from customer
where  customer_id = '&vID';

select 'Contact:', customer_contact
from customer
where  customer_id = '&vID';

select 'Phone: ', customer_phone,
from customer
where  customer_id = '&vID';

select 'Address: ',  customer_address || " " || customer_city || ", " || customer_state || " " || customer_zip
from customer
where  customer_id = '&vID';