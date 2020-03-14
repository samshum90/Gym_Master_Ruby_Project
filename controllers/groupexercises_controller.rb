require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/groupexercise.rb' )
also_reload( '../models/*' )

get '/groupexercises' do
  @group = GroupExercise.all()
  erb ( :"groupexercises/index" )
end

get '/groupexercises/:id' do
  @group = GroupExercise.find(params['id'].to_i)
  erb( :"groupexercises/show" )
end
