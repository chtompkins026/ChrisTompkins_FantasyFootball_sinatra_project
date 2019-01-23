class PlayersController < ApplicationController

  get '/players' do   # should this have the user id?
    @user = current_user
      if logged_in?
        @players = @user.players
        erb :'/users/show'
      else
        redirect to '/login'
      end
  end

  get '/players/new' do
    if logged_in?
      erb :'/players/new'
    else
      redirect '/login'
    end
  end

  post '/players/new' do
    user = current_user
    new_player = Player.create(name: params[:name], team: params[:team], position: params[:position], user_id: user.id)

    unless new_player.valid?
      flash[:error] = "#{new_player.errors.full_messages.join(". ")}"
      redirect to '/players/new'
    else
      user.players.push(new_player)
      flash[:success] = "#{new_player.name} was successfully added"
      redirect to '/players'
    end
  end

  get '/players/:id' do
    @player = Player.find(params[:id])
    erb :'/players/show'
  end

  get '/players/:id/edit' do
    if logged_in?
      @user = current_user
      @player = Player.find_by_id(params[:id])
      if @user.id == @player.user_id
        erb :'/players/edit'
      else
        flash[:error] = "You can only edit players on your team"
        redirect "/players"
      end
    else
      flash[:message] = "Login to edit or delete a your player"
      redirect '/login'
    end
  end

  patch '/players/:id/edit' do
    if logged_in?
      user = current_user
      player = Player.find_by_id(params[:id])
      old_name = player.name
        if player && player.user_id == current_user.id
        player.update(name: params[:name], team: params[:team], position: params[:position], user_id: user.id)
          if player.valid?
            player.save
            flash[:success] = "#{old_name} has been successfully updated to #{player.name}"
            redirect "/players"
          else
            flash[:error] = "#{player.errors.full_messages.join(". ")}"
            redirect "/players/#{params[:id]}/edit"
          end
        else
          flash[:error] = "You can't update players who are not on your team"
          redirect "/players"
        end
      else
        flash[:error] = "You must be logged in to make changes to your team"
        redirect '/login'
    end
  end

  post '/players/:id/delete' do
    player = Player.find(params[:id])
    if logged_in? && player.user_id == session[:user_id]
      player.delete
      flash[:error] = "#{player.name} was successfully deleted"
      redirect to '/players'
    else
      redirect '/login'
    end
  end

end #end of the User Controller
