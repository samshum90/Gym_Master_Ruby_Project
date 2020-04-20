require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/groupexercises_controller')
require_relative('controllers/members_controller')
require_relative('controllers/bookings_controller')
require_relative('controllers/instructors_controller')
require_relative('controllers/schedules_controller')
require_relative('controllers/profiles_controller')
also_reload('models/*')

get '/' do
  erb( :index )
end

# error 404 do
#   @message = "404: We couldn't find that page!"
#   erb(:error)
# end
