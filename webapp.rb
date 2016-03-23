require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require "sinatra/reloader"

require_relative 'config/app_config.rb'

class DUT < Sinatra::Application
  register Sinatra::R18n

  set :bind, '0.0.0.0'

  enable :sessions

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true
  end

  configure :development do
    register Sinatra::Reloader
  end
end

require_relative 'models/init'
require_relative 'routes/init'
