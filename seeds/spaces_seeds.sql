TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;

INSERT INTO spaces (space_name, description, price, booked, user_id) VALUES ('Igloo', 'Nice fireplace but cold outside', 40.00, false, 1);
INSERT INTO spaces (space_name, description, price, booked, user_id) VALUES ('Flat', 'Boring and unremarkable', 120.00, false, 3);