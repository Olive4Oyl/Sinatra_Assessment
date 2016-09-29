require './config/environment'
require 'pry'
# require 'carrierwave'
# require 'carrierwave/orm/activerecord'

class ApplicationController < Sinatra::Base
  configure do
  	enable :sessions
	set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
  	erb :'/index'
  end

helpers do

    def logged_in?
      !!session[:id]
    end

    def current_user
       User.find_by(session[:id])
    end

 end



end