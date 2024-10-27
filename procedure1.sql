create or replace procedure policy_renewal()
language plpgsql as $$
declare
rec record;
begin
for rec in select * from policies
loop
if rec.end_date=current_date 
then
 if exists(select 1 from payments 
 where policy_id=rec.policy_id and payment_date=current_date and amount=rec.premium_amount)
 then
 update policies
 set start_date=rec.end_date,
 end_date=rec.end_date+interval '1 year'
 where policy_id=rec.policy_id;
 end if;
 end if;
end loop;
end;
$$;

--select * from payments;