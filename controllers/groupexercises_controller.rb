require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/groupexercise.rb' )
also_reload( '../models/*' )

get '/groupexercises' do
  @group = GroupExercise.all()
  erb ( :"groupexercises/index" )
end

get '/groupexercises/new' do
  @group = GroupExercise.all
  erb(:"groupexercises/new")
end

get '/groupexercises/:id' do
  @group = GroupExercise.find(params['id'].to_i)
  erb(:"groupexercises/show")
end

get '/groupexercises/:id/edit' do
  @groups = GroupExercise.find( params[:id] )
  erb( :"groupexercises/edit" )
end

# create
post '/groupexercises' do
  groupexercise = GroupExercise.new(params)
  groupexercise.save
  redirect to("/groupexercises")
end

# delete
post '/groupexercises/:id/delete' do
  GroupExercise.delete(params[:id])
  redirect to("/groupexercises")
end

# edit
post '/groupexercises/:id' do
  @groups = GroupExercise.new(params)
  @groups.update
  redirect to("/groupexercises")
end
