insert into user_groups (name)
select distinct t.group_name
from (
  select (jsonb_array_elements($$[
    {"name":"Mari Tamm","email":"mari.tamm@school.ee","group_name":"IT-21"},
    {"name":"Jaan Saar","email":"jaan.saar@school.ee","group_name":"IT-21"},
    {"name":"Kati Kask","email":"kati.kask@school.ee","group_name":"DK-11"},
    {"name":"Andres Põld","email":"andres.pold@school.ee","group_name":"DK-11"},
    {"name":"Liisa Oja","email":"liisa.oja@school.ee","group_name":"ME-31"}
  ]$$::jsonb)) as t
) s
where not exists (select 1 from user_groups g where g.name = (t->>'group_name'));

insert into users (name, email, group_id)
select
  t->>'name',
  t->>'email',
  (select id from user_groups where name = t->>'group_name')
from jsonb_array_elements($$[
  {"name":"Mari Tamm","email":"mari.tamm@school.ee","group_name":"IT-21"},
  {"name":"Jaan Saar","email":"jaan.saar@school.ee","group_name":"IT-21"},
  {"name":"Kati Kask","email":"kati.kask@school.ee","group_name":"DK-11"},
  {"name":"Andres Põld","email":"andres.pold@school.ee","group_name":"DK-11"},
  {"name":"Liisa Oja","email":"liisa.oja@school.ee","group_name":"ME-31"}
]$$::jsonb) t
on conflict (email) do nothing;
