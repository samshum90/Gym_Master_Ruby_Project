require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/booking.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/groupexercise.rb' )

also_reload( '../models/*' )


get '/bookings/:id/new' do
  @members = Member.all
  @groupexercise_id = params[:id]
  @sign_up = GroupExercise.find(params[:id]).members.map {|member| member.id}
  erb(:"/bookings/new")
end

post '/bookings/:groupexercise_id/create' do
  booking = Booking.new(params)
  booking.save
  redirect to ("/groupexercises/#{params['groupexercise_id']}")
end

post '/bookings/:id/delete' do
  booking = Booking.find(params[:id])
  group_id = booking.groupexercise_id
  booking.delete()
  redirect to ("/groupexercises/#{group_id}")
end
