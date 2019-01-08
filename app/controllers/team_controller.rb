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
    @user.players.push(new_player)

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

  get '/team/:id/edit' do
    if logged_in?
      @user = current_user
      @player = Player.find_by_id(params[:id])
      if @user.id == @player.user_id
        erb :'/players/edit_player'
      else
        flash[:error] = "You can only edit players on your team"
        redirect "/users/team"
      end
    else
      flash[:message] = "Login to edit or delete a your player"
      redirect '/login'
    end
  end

  patch '/player/:id/edit' do
    if logged_in?
      @user = current_user
      @player = Player.find_by_id(params[:id])
        if @player && @player.user == current_user
        @player.update(name: params[:name], team: params[:team], position: params[:position], user_id: @user.id)
          if @player.valid?
            @player.save
            session[:message] = "Successfully updated player on your team"
            redirect "/team"
          else
            session[:message] = "Please make sure all fields are filled out"
            redirect "/team/#{params[:id]}/edit"
          end
        else
          session[:message] = "You can't update players who are not on your team"
          redirect "/team"
        end
      else
        session[:message] = "You must be logged in to make changes to your team"
        redirect '/login'
    end
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
