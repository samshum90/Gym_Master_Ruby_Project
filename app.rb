require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/_controller')
require_relative('controllers/_controller')
require_relative('controllers/_controller')

get '/' do
  erb( :index )
end
