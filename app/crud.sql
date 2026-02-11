-- READ
SELECT * FROM booking;

-- CREATE
INSERT INTO booking
(classroom_id, user_or_group_id, lesson_type_id, booking_date, start_time, end_time, participants)
VALUES (1, 1, 1, CURRENT_DATE, '09:00', '10:00', 20);

-- UPDATE
UPDATE booking
SET participants = 30
WHERE id = 1;

-- DELETE
DELETE FROM booking
WHERE id = 1;
