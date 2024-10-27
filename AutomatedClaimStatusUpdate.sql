create or replace function auto_update_status()
returns trigger as $$
begin
IF NEW.amount_claimed<10000 then
NEW.status :='Approved';
NEW.approved_by :='System auto approved';
end if;
return new;
end;
$$ language plpgsql;


create or replace trigger auto_status
before insert on claims
for each row
execute function auto_update_status();