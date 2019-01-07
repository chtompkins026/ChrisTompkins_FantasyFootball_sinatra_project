class UsersController < ApplicationController

  get 'users/signup' do
    if logged_in?
      redirect '/users/team'
    else
      erb :'/users/sign_up'
    end
  end

  post '/signup' do
    if params["username"].empty?
      flash[:error] = "Username is empty" #store keys and strings that will be passed into next page (dictionary already made for me)
      redirect "/signup"
    elsif params["email"].empty?
      flash[:error] = "Email is empty"
      redirect "/signup"
    else
      @user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/team'
    end
  end

  get '/users/login' do
    if logged_in?
      redirect '/team'
    else
      erb :'users/login'
    end
  end

  post '/users/login' do
     user = User.find_by(:username => params[:username])

     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect '/team'
     else
       redirect '/login'
     end
  end



end #end of the user class
