

create function prevent_duplicate()
returns trigger as $$
begin
if exists(select 1 from claims where policy_id=new.policy_id and claim_date=new.claim_date
         and amount_claimed=new.amount_claimed and status in('Pending','Approved','Rejected'))
		 then raise exception 'Claim is Duplicated';
		 end if;
		 return new;
		 end;
		 $$ language plpgsql;

		 create trigger duplicate_prevent
		 before insert on claims
		 for each row
		 execute function prevent_duplicate();