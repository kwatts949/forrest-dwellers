CREATE TABLE users ( id SERIAL PRIMARY KEY, username text,
email text,
password varchar
);

CREATE TABLE spaces ( id SERIAL PRIMARY KEY, space_name text,
description text,
price float,
user_id int,
start_date date,
end_date date,
constraint fk_user foreign key(user_id) references users(id) on delete cascade
);


CREATE TABLE bookings ( id SERIAL PRIMARY KEY, booking_date date, space_id int, user_id int, confirmation boolean,
constraint fk_space foreign key(space_id) references spaces(id) on delete cascade
);