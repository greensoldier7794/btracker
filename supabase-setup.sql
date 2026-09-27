create table finance_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table finance_state enable row level security;

create policy "Users manage own state"
  on finance_state for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
