DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS classes;

CREATE TABLE classes(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  start_time TIME(0),
  price DECIMAL
);

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  DOB DATE
);

CREATE TABLE memberships(
  id SERIAL PRIMARY KEY,
  member_id INT references members(id),
  class_id INT references classes(id),
  type VARCHAR(255)
);
