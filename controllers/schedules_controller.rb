require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/instructor.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/groupexercise.rb' )

also_reload( '../models/*' )

get '/schedules/:id/new' do
  @instructors = Instructor.all
  @member_id = params[:id]
  member = Member.find(params[:id])
  @sign_up = member.instructors.map {|instructor| instructor.id}
    erb(:"/bookings/new")
end

post '/schedules/:member_id/create' do
  schedule = Schedule.new(params)
  schedule.save
  redirect to ("/members/#{params['member_id']}")
end

post '/schedules/:id/delete' do
  schedule = schedule.find(params[:id])
  group_id = schedule.groupexercise_id
  schedule.delete()
  redirect to ("/members/#{member_id}")
end
