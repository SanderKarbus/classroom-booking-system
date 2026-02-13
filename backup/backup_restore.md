# Backup restore test

```bash
psql -U postgres -d classroom_booking -c "select count(*) from bookings; delete from bookings where id=(select id from bookings order by id desc limit 1); select count(*) from bookings;" && psql -U postgres -d classroom_booking -f backup_2026-02-11.sql && psql -U postgres -d classroom_booking -c "select count(*) from bookings;"
```
