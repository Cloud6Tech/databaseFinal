set echo on

prompt ***** Total Sales by Product *****
select product.product_name as "Product Name" sum(orders.qty) as "Total Sale"
from product, orders
where product.product_id = orders.product_id
group by orders.product.id
order by sum(orders.qty);

prompt

prompt ***** Lowest Selling Product *****
select product.product_name as "Product Name" min(sum(orders.qty)) as "Total Sale"
from product, orders
where product.product_id = orders.product_id
group by orders.product.id

prompt

prompt ***** Average Invoice Total *****
select avg(sum(orders.qty * product.prodcut_ppu))
from  orders, product
where orders.product_id = product.prodcut_id
group by orders.invoice_num;

prompt

prompt ***** Employee Sales *****
select employee.employee_lname as "Last Name", employee.employee_fname as "First Name", sum(orders.qty * product.prodcut_ppu) as "Total Sales"
from  orders, product, Employee
where orders.product_id = product.prodcut_id
and employee.employee_id = orders.employee_id
group by orders.employee_id;
order by employee.employee_lname;

promt

prompt ***** Customers Over $250K in Total Orders  *****
select customer.customer_name as "Company Name", employee.employee_fname as "First Name", sum(orders.qty * product.prodcut_ppu) as "Total Sales"
from  orders, product, customer
where orders.product_id = product.prodcut_id 
group by orders.customer_id
having sum(orders.qty * product.prodcut_ppu) > 250000
order by customer.customer_name;
