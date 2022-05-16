--Tarea 3, queries de sakila--

--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?

select c.first_name || ' ' || c.last_name, c.email 
from customer c join address a using (address_id) join city c2 using (city_id) join country c3  
using (country_id) where c3.country  = 'Canada';

--Qué cliente ha rentado más de nuestra sección de adultos?

select count(r.customer_id), c.first_name || ' ' || c.last_name 
from film f join inventory i using (film_id) join rental r using (inventory_id) join customer c using (customer_id)
where f.rating = 'NC-17'
group by c.customer_id 
order by 1 desc 
limit 1;

--Qué películas son las más rentadas en todas nuestras stores?
select B.tienda, B.title,total, c2.city
from (select distinct on (s.store_id) s.store_id tienda, f.title ,count(f.title) total,s.address_id 
from customer c join store s using(store_id) join rental r using(customer_id) join inventory i using(inventory_id) join film f using(film_id)
group by s.store_id,f.title,s.address_id  
order by 1 ,3 desc) B join address a using (address_id) join city c2 using(city_id);



--Cuál es nuestro revenue por store?
select i.store_id tienda, sum(p.amount), a.address 
from inventory i join rental r using(inventory_id)
join payment p using(rental_id)
join store s using (store_id)
join address a using (address_id)
group by i.store_id, a.address 
order by 1 asc;






