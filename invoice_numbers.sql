set echo off
set verify off
set heading on


prompt ***** Total Sales by Product *****
select product.product_name as "Product Name", sum(invoice.quantity) as "Total Sale"
from product, invoice
where product.product_id = invoice.product_id
group by product.product_name
order by product.product_name asc;

prompt

prompt ***** Lowest Selling Product *****
select p.product_name, t.summed as "Quantity"
from product p,(
select product_id, sum(quantity) as summed
from invoice
group by product_id
having sum(quantity) = 
(select min(summed)
from
(select product_id, sum(quantity) as summed
from invoice
group by product_id))) t
where p.product_id = t.product_id;

prompt

prompt ***** Highest Selling Product *****
select p.product_name, t.summed as "Quantity"
from product p,(
select product_id, sum(quantity) as summed
from invoice
group by product_id
having sum(quantity) = 
(select max(summed)
from
(select product_id, sum(quantity) as summed
from invoice
group by product_id))) t
where p.product_id = t.product_id;

prompt


prompt ***** Average Invoice Total *****
column "Average Sale" format $999,999.90
select avg(sum(invoice.quantity * product.product_ppu)) as "Average Sale"
from  invoice, product
where invoice.product_id = product.product_id
group by invoice.invoice_num;

prompt

prompt ***** Employee Sales *****
column "Total Sales" format $999,999.90
select e.employee_lname "Last Name", e.employee_fname as "First Name", sum(t.summed) as "Total Sales"
from customer c, employee e,
(select o.customer_id as cust_id,sum(i.quantity * p.product_ppu) as summed
from orders o, invoice i, product p
where o.invoice_num = i.invoice_num
and p.product_id = i.product_id
group by o.customer_id) t
where c.customer_id = t.cust_id
and c.employee_id = e.employee_id
group by e.employee_lname, e.employee_fname
order by e.employee_lname, e.employee_fname;

prompt

prompt ***** Customers Over $250K in Total Orders  *****
 
column "Total Orders" format $999,999.90
select c.customer_company as "Company Name", t.summed as "Total Orders"
from customer c,
(select o.customer_id as cust_id,sum(i.quantity * p.product_ppu) as summed
from orders o, invoice i, product p
where o.invoice_num = i.invoice_num
and p.product_id = i.product_id
group by customer_id
having sum(i.quantity * p.product_ppu) > 100000) t
where c.customer_id = t.cust_id
order by c.customer_company;
