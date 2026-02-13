-- backup_2026-02-11.sql

INSERT INTO classroom (name, capacity, has_computers) VALUES
('C101', 30, true),
('C202', 20, false)
ON CONFLICT (name) DO NOTHING;

INSERT INTO user_or_group (name, type) VALUES
('Teacher Mari', 'teacher'),
('Group A1', 'group')
ON CONFLICT DO NOTHING;

INSERT INTO lesson_type (name) VALUES
('Lecture'),
('Lab')
ON CONFLICT (name) DO NOTHING;

INSERT INTO booking (classroom_id, user_or_group_id, lesson_type_id, booking_date, start_time, end_time, participants) VALUES
(1, 1, 1, '2026-02-11', '09:00', '11:00', 15),
(2, 2, 2, '2026-02-12', '10:00', '12:00', 25);
