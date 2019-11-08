require 'sinatra'
require 'sinatra/reloader' if development?

Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

#Not sure how/if this works yet
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 300, # In 5 minutes
                           :secret => 'BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiRTEzMmM2YjI3YmUwZTUyYjBiOTM3%0AYjhlMjUyMjZkOTMxMzgxNDFhNTRmMzkwNWVjNzE1MTk3MzZiMjRmODE4NGYG%0AOwBGSSIJY3NyZgY7AEZJIjFYN3MyWm0yZG9yZzd4M0pSVmVZL1ZHOVlrYngx%0AUkRwbjJ5aTI0K0kybWtRPQY7AEZJIg10cmFja2luZwY7AEZ7BkkiFEhUVFBf%0AVVNFUl9BR0VOVAY7AFRJIi1kZjAzN2E4NjI4ZDQ4NThiYmViNTMyMGQ5Zjll%0AYjgyYjIwZWNjZWQ0BjsARg%3D%3D%0A--34122cb595fb8bdae25dfe84c5cea367f2644b7f'




#METHODS

def refreshUserSession
  if session[:user]==nil
    redirect '/'
  end
  session[:user] = session[:user]
end

def fuzzySearch (searched) #https://www.sqlservercentral.com/articles/fuzzy-search
  arrayToReturn = []
  searched.downcase!
  all_users = get_all_users
  all_users.each do |user|
    score = 0;
    index = 0;
    while index < searched.length
      if user['username'].downcase.include?(searched[index..(index+2)])
        score += 1
      end
      index +=1
    end
    arrayToReturn.push({:user => user,:score =>score})
  end
  arrayToReturn.sort!{|a,b| b[:score]<=>a[:score]}
  return arrayToReturn[0..10]
end





#ROUTES

get '/' do
  # if sessionStorage empty then direct to landing else direct to user page
  if session[:user] == nil
    redirect '/Landing'
  else
    redirect '/Home_page'
  end
end

get '/Landing' do
  session[:user] = nil
  @message =""
  if(params["error"]=="1")
    @message ="Incorrect Username or Password"
  end
   erb :Landing_page , layout: :logged_out_layout
end

post '/check_login' do
  user = check_login(params["username"], params["password"])
  if  user == nil
    # Set sessionStorage here
        redirect '/Landing?error=1'
  else
    session[:user] = user
    redirect "/Home_page"
  end
end

get '/SignUp' do
  @error = params[:error].to_i
  case @error
  when 1
    @message = "Username already in use."
  when 2
    @message = "There is an already an account associated with that email address."
  when 3
    @message = "That is not a valid password"
  else
    @message = ""
  end
  erb :Sign_Up, layout: :logged_out_layout
end

post '/newUser' do
# Perform checks and sql functions
# if valid new user add to db and return user to login page
# else try and return to sign-up page
  @outcome = check_new_user(params["username"],params["password"],params["email"])
  if @outcome == nil #Valid User added
    redirect "/Landing"
  else
    redirect "/SignUp?error=#{@outcome}"
  end
end

get '/Home_page' do
  if session[:user] ==nil
    redirect '/'
  end
  @albums = get_user_albums(session[:user]['user_id'])
  erb :home_page
end

get '/Logout' do
  redirect '/Landing'
end

get '/Album' do
  refreshUserSession
  album_id=params['album_id'].to_i
  @album = get_specific_album(album_id)
  if @album ==nil
    redirect '/'
  end

  @user =  get_user(@album['user_id'])
  @is_creator = session[:user]['user_id']==@user['user_id']
  @images = find_album_images(album_id)
  if @album['album_is_public'] =='1' || @is_creator
  erb :album
  else
    redirect '/'
  end
end

get '/Add_new_album' do
  refreshUserSession
  erb :add_album
end

post '/Insert_new_album' do
  refreshUserSession
  album_title =  params['album_title'] =="" ? "default Title": params['album_title'];
  album_description = params['album_description'] == "" ? " " : params['album_description'];
  album_is_public = params['album_is_public']=='on'? 1 : 0;
  album_cover_image = params['album_cover_image'] == "" ? " " : params['album_cover_image']; #Goat image?
  add_album(session[:user]['user_id'],album_title, album_description , album_is_public, album_cover_image)
  redirect '/'
end

post '/Edit_album' do
  refreshUserSession
  @album =  get_specific_album(params['album_id'])
  erb :edit_album
end

patch '/Update_album' do
  refreshUserSession
  album_id = params['album_id']
  album_is_public = params['album_is_public']=='on'? 1 : 0;
  update_album(params['album_id'], params['album_title'], params['album_description'], album_is_public, params['album_cover_image'])
  redirect "/Album?album_id=#{album_id}"
end

delete '/Delete_album' do
  refreshUserSession
  delete_album(params['album_id'])
  redirect '/'
end





get '/Image' do
  refreshUserSession
  @image = find_image(params['image_id'])
  if @image==nil
    redirect '/'
  end
  @album =get_specific_album(@image['album_id'])
  @user =  get_user(@album['user_id'])
  isAlbumPublic = @album['album_is_public']
  @is_creator = session[:user]['user_id']==@user['user_id']
  if isAlbumPublic == '1' || @is_creator
  erb :image
  else
    redirect '/'
  end
end

get '/Add_new_image' do
  refreshUserSession
  @album = get_specific_album(params['album_id'])
  if session[:user]['user_id'] != @album['user_id']
    redirect '/'
  end
  erb :add_image
end

post '/Insert_new_image' do
  refreshUserSession
  image_title = params['image_title'] == "" ? "Default Title" : params['image_title']
  image_description = params['image_description'] == "" ? " " : params['image_description']
  image_url = params['image_url'] == "" ? " " : params['image_url']
  add_new_image(params['album_id'], session[:user]['user_id'], image_title, image_url, image_description)
  redirect "/Album?album_id=#{params['album_id']}"
end

post '/Edit_image' do
  refreshUserSession
  @image = find_image(params['image_id'])
  erb :edit_image
end

patch '/Update_image' do
  refreshUserSession
  update_image(params['image_id'], params['image_title'], params['image_url'], params['image_description'])
  redirect "/Image?image_id=#{params['image_id']}"
end

delete '/Delete_image' do
  refreshUserSession
  album_id = find_image(params['image_id'])['album_id']
  delete_image(params['image_id'])
  redirect "/Album?album_id=#{album_id}"
end


get '/user' do
  refreshUserSession
  @user = get_user_by_username(params['username'])
  if @user ==nil
    redirect '/'
  end
  @albums = get_user_albums(@user['user_id'])
  erb :user_page
end

get '/User_search' do
  refreshUserSession
  @searched = params['username']
  @user = get_user_by_username(@searched)
  if @user != nil
    redirect "/user?username=#{@searched}"
  end
  @potential_users = fuzzySearch(@searched)
  erb :user_search
end


get '/Settings' do
  refreshUserSession
  @error = params[:error].to_i
  @message = ''
  @message2 = ''
  case @error
  when 1
    @message = 'Incorrect Password!'
  when 2
    @message = "New Passwords didn't match!"
  when 3
    @message = "Password Updated!"
  when 4
    @message2 = 'Incorrect Password!'
  end
  erb :settings
end


patch '/Update_password' do
  refreshUserSession
  if params['new_password'] != params['confirm_password']
    redirect '/Settings?error=2'
  end
  if check_login(session[:user]['username'],params['current_password'])
    update_user_password(session[:user]['username'], params['new_password'])
    redirect '/Settings?error=3'
  else
    redirect '/Settings?error=1'
  end
end

delete '/Delete_user' do
  refreshUserSession
  if check_login(session[:user]['username'],params['current_password']) !=nil
     delete_user(session[:user]['username'],params['current_password'],session[:user]['user_id'])
     redirect '/Landing'
  else
    redirect '/Settings?error=4'
  end
end
