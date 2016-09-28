require 'pry'
class ImagesController < UsersController

	get '/images' do 
		@images = Image.all
		erb :'/images/index'
	end 

	get '/images/new' do 
		if !logged_in?
			redirect to "/login"
		end
		erb :'/images/new'
	end 

	post '/images/new' do 
		@user = User.find_by(session[:id])
		@image = Image.create(params[:image])
		binding.pry
	end
 
end