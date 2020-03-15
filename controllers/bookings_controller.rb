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
  group = GroupExercise.find(params[:id])
  @membership_check = group.membership_needed_check()
  @sign_up = group.members.map {|member| member.id}
  if group.booked.to_i >= group.capacity.to_i
    erb(:"/bookings/full")
  else
    erb(:"/bookings/new")
  end
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
