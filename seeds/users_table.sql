CREATE TABLE users ( id SERIAL PRIMARY KEY, username text,
email text,
password varchar
);

CREATE TABLE spaces ( id SERIAL PRIMARY KEY, space_name text,
description text,
price float,
user_id int,
constraint fk_user foreign key(user_id) references users(id) on delete cascade
);