# classroom-booking-system
database

# Import (CSV + JSON + XML)

This folder contains import files required by the assignment.

## 1) CSV import
- classes.csv (classrooms)

Imported with SQL COPY or database import tools.

## 2) JSON import
- teachers.json (users + user groups)
- import_teachers.sql (SQL script that inserts groups and users)

## 3) XML import
- bookings.xml (bookings)
- import_bookings.py (example script that parses XML and inserts into PostgreSQL)

Note: The XML import script is provided as a working example; the assignment requires the XML format and import logic to be present.

## CRUD functionality

Basic CRUD operations are demonstrated using SQL queries in `crud.sql`.

### Application type

The database application is implemented as a simple CLI-based solution using SQL queries.
CRUD operations and a statistical view are demonstrated without a graphical user interface.

## CRUD Demonstration

### Read bookings
![Read bookings](assets/read_bookings.png)

### Classroom usage statistics
![Classroom usage statistics](assets/statistics_classroom_usage.png)

## Quality Assurance

### Test results
![Test results](assets/test_evidence.png)

### CI/CD Workflow
![CI/CD pipeline](assets/ci-cd-workflow-screenshot2.png)

### CI/CD Workflow (earlier)
![CI/CD pipeline earlier](assets/ci-cd-workflow-screenshot.png)

## Database Design

### ERD Diagram
![ERD diagram](assets/erd_crowsfoot.png)

### UML Class Diagram
![UML class diagram](assets/uml_class.png)
