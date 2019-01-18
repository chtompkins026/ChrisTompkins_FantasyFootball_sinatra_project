class UsersController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect '/team'
    else
      erb :'/users/sign_up'
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
       flash[:error] = "Your username and password are incorrect. Please try again"
       redirect '/login'
     end
  end

  get '/users/:slug' do
    if logged_in?
      @user = current_user
      if @user = User.find_by_slug(params[:slug])
        @players = @user.players
        redirect '/team'
      else
        flash[:error] = "You must be logged in to view your football page"
        redirect '/login'
      end
    else
      flash[:error] = "You must be logged in to view your football page"
      redirect '/login'
    end
  end

  post '/users/signup' do
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



  get '/logout' do

    session.destroy
    redirect to '/'

  end

end #end of the user class
