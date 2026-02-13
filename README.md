# classroom-booking-system
database

# Import documentation

This folder contains data import examples for the classroom booking system.

## CSV import
- classes.csv – classroom data
Imported using SQL COPY or database import tools.

## JSON import
- teachers.json – teachers and groups
Imported using SQL script import_teachers.sql.

## XML import
- bookings.xml – booking data
XML structure prepared for programmatic import.
Import logic is demonstrated in import_bookings.py.

Note: XML import script requires a PostgreSQL connection string (DATABASE_URL).
