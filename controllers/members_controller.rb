require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/member.rb' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all()
  erb ( :"members/index" )
end

get '/members/new' do
  @members = Member.all
  erb(:"members/new")
end

get '/members/:id' do
  @members = Member.find(params['id'].to_i)
  erb( :"members/show" )
end

get '/members/:id/edit' do
  @members = Member.find( params[:id] )
  erb( :"members/edit" )
end

post '/members' do
  member = Member.new(params)
  member.membership_status = "Active"
  member.update
  member.save
  redirect to("/members")
end

post '/members/:id/delete' do
  Member.delete(params[:id])
  redirect to("/members")
end

post '/members/:id/deactivate' do
  members = Member.find(params['id'].to_i)
  members.membership_status = "Deactived"
  members.update
  redirect to("/members")
end

post '/members/:id/activate' do
  members = Member.find(params['id'].to_i)
  members.membership_status = "Active"
  members.update
  redirect to("/members")
end

post '/members/:id' do
  @members = Member.new(params)
  @members.update
  redirect to("/members")
end
