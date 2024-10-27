create function audit_Payments()
returns trigger as $$
begin
if TG_OP='INSERT' then
insert into audit_payments(claim_id,operation,operation_date)
values(NEW.policy_id,'INSERT',now());
elsif TG_OP='UPDATE' then
insert into audit_payments(claim_id,operation,operation_date)
values(NEW.policy_id,'UPDATE',now());
elsif TG_OP='DELETE' then
insert into audit_payments(claim_id,operation,operation_date)
values(NEW.policy_id,'DELETE',now());
end if;
return null;
end;
$$ language plpgsql;

create trigger payment_audit
after insert or update or delete on payments
for each row
execute function audit_Payments();

