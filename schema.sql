CREATE TABLE lesson_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE classroom (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL CHECK (capacity > 0),
    has_computers BOOLEAN DEFAULT true
);

CREATE TABLE user_or_group (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('teacher', 'group'))
);

CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    classroom_id INTEGER NOT NULL REFERENCES classroom(id) ON DELETE CASCADE,
    user_or_group_id INTEGER NOT NULL REFERENCES user_or_group(id) ON DELETE CASCADE,
    lesson_type_id INTEGER REFERENCES lesson_type(id),
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    participants INTEGER NOT NULL CHECK (participants >= 0),
    CHECK (end_time > start_time)
);

CREATE VIEW classroom_usage_hours AS
SELECT 
    classroom_id,
    booking_date,
    SUM(EXTRACT(EPOCH FROM (end_time - start_time)) / 3600) AS total_hours
FROM booking
GROUP BY classroom_id, booking_date;

-- N:M relation: booking <-> user_or_group (participants)
create table if not exists booking_participants (
  booking_id int not null references booking(id) on delete cascade,
  user_or_group_id int not null references user_or_group(id) on delete cascade,
  role text default 'participant',
  primary key (booking_id, user_or_group_id)
);
