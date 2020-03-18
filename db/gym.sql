DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS groupexercises;
DROP TABLE IF EXISTS instructors;

CREATE TABLE instructors(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  speciality VARCHAR(255)
);

CREATE TABLE groupexercises(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  set_date DATE,
  start_time TIME(0) NOT NULL,
  price DECIMAL(5,2),
  capacity INT,
  instructor_id INT references instructors(id) ON DELETE CASCADE
);

CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  date_of_birth DATE,
  membership_type VARCHAR(255),
  membership_status VARCHAR(255)
);

CREATE TABLE schedules(
  id SERIAL PRIMARY KEY,
  instructor_id INT references instructors(id) ON DELETE CASCADE,
  member_id INT references members(id) ON DELETE CASCADE,
  meet_date DATE,
  meeting_time TIME(0) NOT NULL
);

CREATE TABLE bookings(
  id SERIAL PRIMARY KEY,
  member_id INT references members(id) ON DELETE CASCADE,
  groupexercise_id INT references groupexercises(id) ON DELETE CASCADE
);
