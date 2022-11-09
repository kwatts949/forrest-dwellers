CREATE TABLE users ( id SERIAL PRIMARY KEY, username text,
date text,
password varchar
);

CREATE TABLE spaces ( id SERIAL PRIMARY KEY, space_name text,
description text,
price float,
user_id int,
constraint fk_user foreign key(user_id) references users(id) on delete cascade
);

CREATE TABLE bookings ( id SERIAL PRIMARY KEY, booking_date date, space_id int, 
constraint fk_space foreign key(space_id) references spaces(id) on delete cascade
);