require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')
require_relative( '../models/member.rb' )
require_relative( '../models/schedule.rb' )
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
  member = Member.find(params['id'].to_i)
  @schedule = member.schedules
  @members = member
  erb( :"members/show" )
end

get '/members/:id/edit' do
  @members = Member.find( params[:id] )
  erb( :"members/edit" )
end

get '/members/:id/edit_deactive' do
  @members = Member.find( params[:id] )
  erb( :"members/edit_deactive" )
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
  members.membership_status = "Deactivated"
  members.update
  redirect to("/members")
end

post '/members/:id/activate' do
  members = Member.find(params['id'].to_i)
  members.membership_status = "Active"
  members.update
  redirect to("/members")
end

post '/members/:id/edit_deactive' do
  @members = Member.new(params)
  @members.update
  redirect to("/members")
end

post '/members/:id' do
  @members = Member.new(params)
  @members.membership_status = "Active"
  @members.update
  redirect to("/members")
end
