TRUNCATE TABLE users RESTART IDENTITY CASCADE;

INSERT INTO users (username, email, password) VALUES ('George', 'george@makers.com', 'password');
INSERT INTO users (username, email, password) VALUES ('Kay', 'kay@makers.com', '1234');
INSERT INTO users (username, email, password) VALUES ('Mike', 'mike@makers.com', 'qwerty');
INSERT INTO users (username, email, password) VALUES ('Henry', 'henry@makers.com', 'fido');