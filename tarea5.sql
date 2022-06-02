--querido xuxo, como diría jack the ripper, vámonos por partes.

--1) saquemos las películas por tienda.
with cuenta_pelis as (select i.store_id as store, count(i.inventory_id) as num_peliculas 
	from inventory i
	group by i.store_id),
	
--2) quiero guardar cuántos me cabrían máximo considerando los 50 kilos y los 500 gramos de la peli.
	maxi_pelis as (select 50/0.5 as cuantas),

--3) tengo que considerar la altura del cilindro. suponiendo que los distanciamos un centímetro.
	altura_cil as (select 2.5*mp.cuantas as altura from maxi_pelis mp ),
	
--4) ahora consideraremos el radio del cilindro. 
	--entrarán exacto si el radio es igual a la mitad de una diagonal de una película 
	radio_cil as (select sqrt(power(30/2,2) + power(21/2,2)) as radio)
	
--5) drum roll!! tamos listos para el volumen.
	select h.altura, r.radio, pi()*power(r.radio,2)*h.altura as volumen from radio_cil r, altura_cil h;

--Listo!! ahora saquemos la cantidad de cilindros por tienda.

--1) saquemos las películas por tienda.
with cuenta_pelis as (select i.store_id as store, count(i.inventory_id) as num_peliculas 
	from inventory i
	group by i.store_id)
  
 --2) ahora lo dividimos.
	
	select cp.store, ceil(cp.num_peliculas/100) as "cilindros por tienda" from cuenta_pelis cp;
  
  --PS: estuve trabajando con Diana :)
