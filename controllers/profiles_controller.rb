require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/profile' )
require_relative( '../models/member' )


also_reload( '../models/*' )


get '/profiles/:id/new' do
  @members = Member.find(params[:id])
  erb(:"/profiles/new")
end
get '/profiles/:id/edit' do
  @members = Member.find(params[:id])
  @profiles = Profile.find_by_member_id(params[:id])
  erb(:"/profiles/edit")
end

post '/profiles/:id/edit_image' do
  @profiles = Profile.find( params[:id] )
  org_member_id = @profiles.member_id
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/profile_pics/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  @profiles = Profile.new(params)
  @profiles.member_id = org_member_id
  @profiles.photo_url = @filename
  @profiles.update

  redirect to("/members/#{org_member_id}")
end

post '/profiles/:member_id/save_image' do
  @members = Member.find(params[:member_id].to_i)
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/profile_pics/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end

  @profile = Profile.new({
    'member_id' => @members.id,
    'photo_url' => @filename
    })
  @profile.save

  redirect to("/members/#{@members.id}")
end
