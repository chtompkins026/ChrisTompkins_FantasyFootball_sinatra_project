class TeamController < ApplicationController

  get '/team' do
      if logged_in?
        @players = Player.all
        erb :'users/team'
      else
        redirect to '/users/login'
      end
  end


end #end of the User Controller
