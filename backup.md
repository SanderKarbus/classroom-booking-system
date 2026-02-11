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
