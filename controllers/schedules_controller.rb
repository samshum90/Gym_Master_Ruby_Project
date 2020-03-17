require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/instructor.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/groupexercise.rb' )
require_relative( '../models/schedule.rb' )

also_reload( '../models/*' )

get '/schedules/:id/new' do
  @instructors = Instructor.all
  @member_id = params[:id]
  member = Member.find(params[:id])
  @sign_up = member.instructors.map {|instructor| instructor.id}
    erb(:"/schedules/new")
end

post '/schedules/:member_id/create' do
  schedule = Schedule.new(params)
  schedule.save
  redirect to ("/members/index")
end

post '/schedules/:id/delete_in_instructor' do
  schedule = Schedule.find(params[:id])
  schedule.delete()
  redirect to ("/instructors/#{schedule.instuctor_id}")
end

post '/schedules/:id/delete' do
  schedule = Schedule.find(params[:id])
  schedule.delete()
  redirect to ("/members/#{schedule.member_id}")
end
