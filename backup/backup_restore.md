# Backup restore test

```bash
psql -U postgres -d classroom_booking -c "select count(*) from bookings; delete from bookings where id=(select id from bookings order by id desc limit 1); select count(*) from bookings;" && psql -U postgres -d classroom_booking -f backup_2026-02-11.sql && psql -U postgres -d classroom_booking -c "select count(*) from bookings;"
```

# Backup Strategy

## Creating a backup

Database backups can be created using:

```bash
pg_dump -U postgres -d classroom_booking -f backup.sql
```

## Restoring from backup

To restore the database from a backup file:

```bash
psql -U postgres -d classroom_booking -f backup.sql
```

## Supabase Backups

In Supabase, backups can be managed from:

Project Settings → Database → Backups

Backups should be scheduled daily to ensure data safety.
