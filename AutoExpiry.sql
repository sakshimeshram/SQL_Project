create function auto_expiring()
returns trigger as $$
begin
if new.end_date<current_date then
update policies set status='Expired'
where policy_id=new.policy_id	;
end if;
return new;
end;
$$ language plpgsql;

create trigger expiring_auto
before insert or update on policies
for each row
execute function auto_expiring();