require "./config/environment"
require "sinatra/base"
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
      set :public_folder, 'public'
      set :views, File.expand_path('../../views', __FILE__)
      enable :sessions
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

#test 123
