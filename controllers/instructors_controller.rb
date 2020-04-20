require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/Instructor.rb' )
also_reload( '../models/*' )

get '/instructors' do
  @instructors = Instructor.all()
  erb ( :"instructors/index" )
end

get '/instructors/new' do
  @instructors = Instructor.all
  erb(:"instructors/new")
end

get '/instructors/:id' do
  @instructors = Instructor.find(params['id'].to_i)
  erb(:"instructors/show")
end

get '/instructors/:id/edit' do
  @instructors = Instructor.find( params[:id] )
  erb( :"instructors/edit" )
end

# create
post '/instructors' do
  instructor = Instructor.new(params)
  instructor.save
  redirect to("/instructors")
end

# delete
post '/instructors/:id/delete' do
  Instructor.delete(params[:id])
  redirect to("/instructors")
end

# edit
post '/instructors/:id' do
  @instructors = Instructor.new(params)
  @instructors.update
  redirect to("/instructors")
end
