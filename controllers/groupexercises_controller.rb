require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/groupexercise.rb' )
require_relative( '../models/instructor.rb' )
also_reload( '../models/*' )

get '/groupexercises' do
  @group = GroupExercise.all()
  erb ( :"groupexercises/index" )
end

get '/groupexercises/new' do
  @group = GroupExercise.all
  @instructor = Instructor.all
  erb(:"groupexercises/new")
end

get '/groupexercises/date' do
  @group = GroupExercise.all()
  erb(:"groupexercises/date")
end

get '/groupexercises/day' do
  @group = GroupExercise.all()
  erb(:"groupexercises/day")
end

get '/groupexercises/:id' do
  @group = GroupExercise.find(params['id'].to_i)
  erb(:"groupexercises/show")
end

get '/groupexercises/:id/edit' do
  @groups = GroupExercise.find( params[:id] )
  @instructors = Instructor.all
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
