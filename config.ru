require './config/environment'
require 'sinatra/flash'
require 'sinatra/base'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

Dir.glob('./app/{controllers}/*.rb').each { |file| require file }

use Rack::MethodOverride
run ApplicationController

# pull in the helpers and controllers

# # map the controllers to routes
