class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/players'
    else
      erb :'/users/new'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/players'
    else
      erb :'users/index'
    end
  end

  post '/login' do
     user = User.find_by(:username => params[:username])

     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect '/players'
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
        redirect '/players'
      else
        flash[:error] = "You must be logged in to view your football page"
        redirect '/login'
      end
    else
      flash[:error] = "You must be logged in to view your football page"
      redirect '/login'
    end
  end

  post '/signup' do
    @user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
    unless @user.valid?
      flash[:error] = "#{@user.errors.full_messages.join(". ")}"
      redirect "/signup"
    else
      @user.save
      session[:user_id] = @user.id
      redirect '/players'
    end
  end


  get '/logout' do

    session.destroy
    redirect to '/'

  end

end #end of the user class
