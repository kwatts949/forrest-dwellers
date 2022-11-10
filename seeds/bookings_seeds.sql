TRUNCATE TABLE bookings RESTART IDENTITY;

INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-04-12', 1, 1, false);
INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-06-01', 1, 1, true);
INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-11-03', 1, 1, false);
INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-07-24', 2, 1, false);
INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-12-02', 2, 1, true);
INSERT INTO bookings (booking_date, space_id, confirmation) VALUES ('2023-06-14', 2, 1, false);
