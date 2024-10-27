create or replace procedure auto_payments(v_payment_method varchar)
language plpgsql as $$
declare
rec record;
begin
for rec in select * from policies
loop
 if exists(select 1 from payments 
 where policy_id=rec.policy_id and amount=rec.premium_amount)
 then
 update policies
 set start_date=rec.end_date,	
 end_date=rec.end_date+interval '1 year'
 where policy_id=rec.policy_id;
 end if;
end loop;
end;
$$;

--select * from payments;