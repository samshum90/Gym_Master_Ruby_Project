require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/instructor.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/groupexercise.rb' )
require_relative( '../models/schedule.rb' )

also_reload( '../models/*' )

get '/schedules/:id/new_in_member' do
  @instructors = Instructor.all
  @member_id = params[:id]
  member = Member.find(params[:id])
    erb(:"/schedules/new")
end

get '/schedules/:schedule_id/edit_in_member' do
  @instructors = Instructor.all
  @schedule = Schedule.find(params[:schedule_id])
  @member = Member.all
  erb(:"/schedules/edit")
end

post '/schedules/:member_id/create' do
  @schedule = Schedule.new(params)
  @schedule.save
  redirect to ("/members/#{params[:member_id]}")
end

post '/schedules/:id/edit' do
  @schedule = Schedule.new(params)
  @schedule.update
  redirect to ("/members/#{params[:member_id]}")
end

post '/schedules/:id/delete' do
  schedule = Schedule.find(params[:id])
  schedule.delete()
  redirect to ("/instructors/#{schedule.instructor_id}")
end

post '/schedules/:id/delete_in_member' do
  schedule = Schedule.find(params[:id])
  schedule.delete()
  redirect to ("/members/#{schedule.member_id}")
end
