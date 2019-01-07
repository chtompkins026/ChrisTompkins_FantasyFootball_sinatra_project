require './config/environment'
require 'sinatra/flash'
require 'sinatra/base'
require_relative 'app/controllers/users_controller'
require_relative 'app/controllers/team_controller'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController
use UsersController
use TeamController
