class TeamController < ApplicationController

  get '/team' do
    @user = current_user
      if logged_in?
        @players = @user.players
        erb :'/users/team'
      else
        redirect to '/users/login'
      end
  end

  get '/team/new' do
    erb :'/players/create_player'
  end

  post '/team/new' do
    @user = current_user
    new_player = Player.create(name: params[:name], team: params[:team], position: params[:position], user_id: @user.id)

    unless new_player.valid?
      flash[:error] = "Duplicate player can not be added"
      redirect to '/team/new'
    else
      redirect to '/team'
    end
  end

  get '/team/:id' do
    @player = Player.find(params[:id])
    erb :'/players/show_player'
  end


  post '/team/:id/delete' do
    @player = Player.find(params[:id])
    if logged_in? && @player.user_id == session[:user_id]
      @player.delete
      flash[:error] = "Player successfully deleted"
      redirect to '/team'
    else
      redirect '/login'
    end
  end

end #end of the User Controller
