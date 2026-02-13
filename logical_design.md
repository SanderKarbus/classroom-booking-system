# Logical Design

## Overview
This database implements a classroom booking system.

## Tables

- **classroom** – stores classroom information (name, capacity, computer availability)
- **user_or_group** – represents either a teacher or a student group
- **lesson_type** – lookup table for lesson categories
- **booking** – stores booking information including date, time and participants

## Relationships

- One classroom can have many bookings (1:N)
- One user/group can have many bookings (1:N)
- One lesson type can be used in many bookings (1:N)

## Business Rules

1. participants >= 0 (CHECK constraint in booking table)
2. end_time > start_time (CHECK constraint in booking table)
3. capacity > 0 (CHECK constraint in classroom table)

Foreign keys ensure referential integrity between related tables.

The N:M relationship is implemented using the junction table `booking_participants`, which links `booking` and `user_or_group` (participants).
