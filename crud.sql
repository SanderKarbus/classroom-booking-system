-- READ: view all bookings
select * from booking;

-- CREATE: add new booking
insert into booking (
  classroom_id,
  user_or_group_id,
  lesson_type_id,
  booking_date,
  start_time,
  end_time,
  participants
) values (
  1, 1, 1,
  '2026-03-01',
  '10:00',
  '12:00',
  20
);

-- UPDATE: update participants
update booking
set participants = 25
where id = 1;

-- DELETE: remove booking
delete from booking
where id = 1;
