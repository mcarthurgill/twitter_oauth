get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  user = User.find_or_create_by_username_and_oauth_token_and_oauth_secret(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)

  session[:user_id] = user.id

  redirect '/tweet'
end

get '/tweet' do
  erb :tweet
end

post '/tweet' do
  user = User.find_by_id(session[:user_id])

  twitter_user = Twitter::Client.new(
    :oauth_token => user.oauth_token,
    :oauth_token_secret => user.oauth_secret
  )

  if twitter_user.update(params[:tweet])
    erb :_success, layout: false
  else
    erb :_failure, layout: false
  end
end