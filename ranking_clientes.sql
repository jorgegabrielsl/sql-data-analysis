with fat_clientes as (
	select 
		P.customer_id as cd_cliente,
		sum(P.amount) as valor_total,
		count(P.payment_id) as qtd_pagamento
	from public.payment P

	group by
		P.customer_id

	having 
		count(P.payment_id)>5
		
)

select 
fc.*,
Rank() over(order by valor_total DESC)

from fat_clientes fc

where EXISTS (
	select 1
	 FROM rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id
    JOIN film_category fc2 ON fc2.film_id = i.film_id
    JOIN category c ON c.category_id = fc2.category_id
    WHERE r.customer_id = fc.cd_cliente
      AND c.name = 'Action'
	
)
