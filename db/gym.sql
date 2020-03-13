DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS groupexercises;

CREATE TABLE groupexercises(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  start_time TIME (0) NOT NULL,
  price DECIMAL(5,2),
  capacity INT
);

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  DOB DATE
);

CREATE TABLE memberships(
  id SERIAL PRIMARY KEY,
  member_id INT references members(id),
  groupexercise_id INT references groupexercises(id),
  type VARCHAR(255)
);
