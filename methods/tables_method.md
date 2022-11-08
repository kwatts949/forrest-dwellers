# **Two Tables Design Recipe Template**

## **1. Extract nouns from the user stories or specification**

# (analyse only the relevant part - here the final line).
Headline specifications
Any signed-up user can list a new space.
Users can list multiple spaces.
Users should be able to name their space, provide a short description of the space, and a price per night.
Users should be able to offer a range of dates where their space is available.
Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
Nights for which a space has already been booked should not be available for users to book that space.
Until a user has confirmed a booking request, that space can still be booked for that night.

`Nouns:

user, space

## **2. Infer the Table Name and Columns**

| Record | Properties |
| --- | --- |
| user | user_name, email, password |
| space | space_name, description, price, booked?, user_id |

1. Name of the first table (always plural): `user`
    
    Column names: `user_name`, `email`, `password`
    
2. Name of the second table (always plural): `space`
    
    Column names: `space_name`, `description`, `price`, `booked`, `user_id`
    

## **3. Decide the column types.**

Table: user
id: SERIAL
username: text
email: text
password: varchar

Table: space
id: SERIAL
space_name: text
description: text
price: float
booked: bool
user_id: int

## **4. Decide on The Tables Relationship**

1. Can one [user] have many [spaces]? (Yes)
2. Can one [space] have many [user]? (No)

You'll then be able to say that:

1. **[user] has many [spaces]**
2. And on the other side, **[space] belongs to [user]**
3. In that case, the foreign key is in the table [space]

## **4. Write the SQL.**

- `- EXAMPLE
-- file: users_table.sql

CREATE TABLE users ( id SERIAL PRIMARY KEY, username text,
email text,
password varchar
);

CREATE TABLE spaces ( id SERIAL PRIMARY KEY, space_name text,
description text,
price float,
user_id int
-- The foreign key name is always {other_table_singular}_id user_id int, constraint fk_user foreign key(user_id) references users(id) on delete cascade
);`

## **5. Create the tables.**

`psql -h 127.0.0.1 database_name < albums_table.sql`