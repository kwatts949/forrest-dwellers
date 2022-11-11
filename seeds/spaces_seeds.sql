TRUNCATE TABLE spaces RESTART IDENTITY CASCADE;

INSERT INTO spaces (space_name, description, price, user_id, start_date, end_date) VALUES ('Igloo', 'Nice fireplace but cold outside', 40.00, 1, '2022-11-01', '2022-11-25');
INSERT INTO spaces (space_name, description, price, user_id, start_date, end_date) VALUES ('Flat', 'Boring and unremarkable', 120.00, 3, '2022-11-01', '2022-11-25');