DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS groupexercises;

CREATE TABLE groupexercises(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  start_time TIME(0) NOT NULL,
  price DECIMAL(5,2),
  capacity INT
);

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  date_of_birth DATE,
  membership_type VARCHAR(255)
);

CREATE TABLE bookings(
  id SERIAL PRIMARY KEY,
  member_id INT references members(id) ON DELETE CASCADE,
  groupexercise_id INT references groupexercises(id) ON DELETE CASCADE
);
