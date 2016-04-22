set echo on

prompt ***** Total Sales by Product *****
select product.product_name as "Product Name", sum(orders.quantity) as "Total Sale"
from product, orders
where product.product_id = orders.product_id
group by product.product_name
order by sum(orders.quantity) desc;

prompt

prompt ***** Lowest Selling Product *****
select product_name, min(total) as "total"
from
(select product.product_name, sum(orders.quantity)  as total
from product, orders
where product.product_id = orders.product_id
group by product.product_name) ;

prompt

prompt ***** Average Invoice Total *****
select avg(sum(orders.quantity * product.product_ppu)) as "Average Sale"
from  orders, product
where orders.product_id = product.product_id
group by orders.invoice_num;

prompt

prompt ***** Employee Sales *****
select employee.employee_lname as "Last Name", employee.employee_fname as "First Name", sum(orders.quantity * product.product_ppu) as "Total Sales"
from  orders, product, Employee
where orders.product_id = product.product_id
and employee.employee_id = orders.employee_id
group by employee.employee_lname, employee.employee_fname
order by employee.employee_lname;

prompt

prompt ***** Customers Over $250K in Total Orders  *****
select customer.customer_company as "Company Name", sum(orders.quantity * product.product_ppu) as "Total Sales"
from  orders, product, customer, employee
where orders.product_id = product.product_id 
and orders.customer_id = customer.customer_id
group by customer.customer_company
having sum(orders.quantity * product.product_ppu) > 250000
order by customer.customer_company;
