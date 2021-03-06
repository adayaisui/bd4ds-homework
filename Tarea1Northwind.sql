--Tarea 1 pt1--
--¿Qué contactos de proveedores tiene la posición de sales representative?
select s.contact_name from suppliers s where s.contact_title = 'Sales Representative';

--¿Qué contactos de proveedores no son marketing managers?
select s.contact_name from suppliers s where s.contact_title != 'Marketing Manager';

--¿cuáles ordenes no vienen de clientes de Estados Unidos?
select o.order_id, c.country  from orders o join customers c on o.customer_id =c.customer_id where c.country != 'USA';

--¿Qué productos de los que transportamos son quesos?
select distinct p.product_id, p.product_name 
from categories c join products p using (category_id)
join order_details od using (product_id)
join orders o using (order_id)
where shipped_date is not null 
and c.description = 'Cheeses';

--¿Qué ordenes van a Bélgica o Francia?
select o.order_id from orders o where o.ship_country = 'France' or o.ship_country = 'Belgium' ;

--¿Qué ordenes van a LATAM?
select o.order_id from orders o where o.ship_country in ('Brazil', 'Venezuela', 'Argentina', 'Mexico');

--¿Qué ordenes NO van a LATAM?
select o.order_id from orders o where o.ship_region not in ('Brazil', 'Venezuela', 'Argentina', 'Mexico') ;

--Necesitamos los nombre completos de los empleados, nombres y apellidos unidos en un mismo registro***
select e.first_name, e.last_name  from employees e;

--¿Cuánta lana tenemos en el inventario?
select sum(p.unit_price*p.units_in_stock) from products p where p.units_in_stock != 0;

---Tarea pt2---
--Obtener un reporte de edades de los empleados para checar su elegibilidad para seguro de gastos médicos mayores--
select e.birth_date, e.first_name from employees e group by e.first_name, e.birth_date order by e.birth_date desc  ;

--¿Cuál es la orden más reciente por cliente?
select o.order_id, c.company_name, o.order_date  from orders o join customers c on o.customer_id =c.customer_id 
group by c.customer_id, o.order_id  order by o.order_date desc ;

--De nuestros clientes, ¿qué función desempeñan y cuántos son?

select count(c.customer_id), c.contact_title  from customers c group by c.contact_title ;

--¿Cuántos productos tenemos de cada categoría?

select count(p.product_id), c.category_name  from products p join categories c on p.category_id =c.category_id 
group by c.category_name ;

--Cómo podemos generar el reporte de reorder?
select p.product_name, reorder_level, p.quantity_per_unit 
from products p, suppliers s
where reorder_level<=15
group by p.product_id order by product_name;

--¿A dónde va nuestro envío más voluminoso?--
select c.country from customers c join orders o on c.customer_id =o.customer_id 
join order_details od on o.order_id =od.order_id order by od.quantity desc limit 1;

--cómo creamos una columna en costumers que nos diga si un cliente es bueno, regular o malo--

select o.customer_id, sum((od.unit_price-od.unit_price * od.discount)*od.quantity),
case 
	when sum((od.unit_price-od.unit_price* od.discount)*od.quantity)> 100000 then 'overachiever'
	when sum((od.unit_price-od.unit_price*od.discount)*od.quantity)< 50000 then 'underachiever'
	else 'normal'
end as rating
from order_details od, orders o group by o.customer_id; 


--qué colaboradores chambearon durante las fiestas de navidad?
select e.first_name, o.order_date 
from employees e, orders o
where cast(o.order_date as text) like '%-12-25'
group by e.first_name, e.employee_id, o.order_date;

--qué productos mandamos en navidad?

select o.order_date, p.product_id 
from orders o, products p 
where cast(o.shipped_date as text) like '%-12-25';

--qué país recibe el mayor volumen de producto?
select * from order_details od;
select sum(od.quantity), o.ship_country from order_details od join orders o using(order_id)
group by o.ship_country 
order by sum(od.quantity) desc limit 1;