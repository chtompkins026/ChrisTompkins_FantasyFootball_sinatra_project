require_relative './config/environment'

# require 'sinatra/flash'
# require 'sinatra/base'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use UsersController
use PlayersController
run ApplicationController
