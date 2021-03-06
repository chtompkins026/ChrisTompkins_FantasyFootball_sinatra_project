require "./config/environment"

class ApplicationController < Sinatra::Base

  configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "panda"
      register Sinatra::Flash
    end

    get '/' do
      erb :index
    end


# Helper Section
    helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end

    end  #end of helpers

end #end of the Application class
