# Gym Master Ruby Project

[Live App on Heroku](https://gym-master-3000.herokuapp.com)

This is my first Full stack app built with Ruby using Sinatra for the frontend and PostgresSQL as backend.
My First Solo week long project built during CodeClan's professional software development course.
Following MVC design with Restful routes.

The project is designed to be used in a gym to manage members, classes, and Instructors.

![alt text](https://github.com/samshum90/Solo_Ruby_Project_Gym/raw/master/public/readme/Gym_App.gif "Gym App Gif")

### Features:
* Create, read, update, and delete: members, Classes and Instructors
* Class booking creation is limited by class capacity, active membership, membership type and cannot be rebooked 
* Pictures can be uploaded to the member profiles
* Classes can be filtered to view the classes scheduled for today

### Project setup

Install required modules, create and seed database.

```ruby
bundle install
createdb gym
ruby db/seeds.rb
```

Using the project

Host the app locally using Sinatra, defaults to port 4567

```ruby
ruby app.rb
```
