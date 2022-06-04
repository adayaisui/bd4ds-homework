--Una de las métricas para saber si un cliente es bueno, aparte de la suma y el promedio de sus pagos, es si tenemos 
--una progresión consistentemente creciente en los montos.

--Debemos calcular para cada cliente su promedio mensual de deltas en los pagos de sus órdenes en la tabla 
--order_details en la BD de Northwind, es decir, la diferencia entre el monto total de una orden en tiempo t 
--y el anterior en t-1, para tener la foto completa sobre el customer lifetime value de cada miembro de nuestra
-- cartera.

--ok, tenemos que ver los pagos para poder saber qué rollo.

with pagos as(
	select o.customer_id as customer, o.order_id as orden, od.unit_price*od.quantity as pq, o.order_date as fecha
	from order_details od 
	join orders o 
	using (order_id),
  
  deltas as (
	select extract(year from p.fecha) as ano, extract(month from p.fecha) as mes, p.customer as customer,(pq-lag(pq) over (partition by p.customer order by fecha asc)) as delta 
	from pagos p)

select d.ano, d.mes, d.cliente, avg(d.delta) 
from deltas d 
group by d.mes, d.ano, d.customer 
order by d.customer asc, d.ano asc, d.mes asc;

