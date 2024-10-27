create function auto_cal_commision()
returns trigger as $$
begin
update agents
set commission_rate=commission_rate+(select (premium_amount*10)/100 from policies p where a.agent_id=p.agent_id)
where agent_id=NEW.agent_id;
return null;
end;
$$ language plpgsql;


create trigger auto_commi
after insert or update on agents
for each row
execute function auto_cal_commision();