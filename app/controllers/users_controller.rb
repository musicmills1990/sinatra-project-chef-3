class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"users/signup"
    else
      redirect "/"
    end
  end


  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect "/"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:errors] = "Please don't leave any fields blank. Please try again."
      redirect '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if
        @user.save
        session[:user_id] = @user.id
        redirect '/'
      else
        flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}."
        redirect '/signup'
      end
    end
  end

  post '/login' do
  @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/'
    else
      flash[:errors] = "Incorrect Username or Password. Please try again."
      redirect '/login'
    end
  end


  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "You have been successfully logged out. See you soon!"
      redirect '/'
    else
      redirect '/'
    end
  end
end
