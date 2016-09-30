require 'pry'
class ImagesController < UsersController

	# get '/images' do 
	# 	@images = Image.all
	# 	erb :'/images/index'
	# end 

	get '/images/new' do 
		if logged_in? && current_user.id == @board.user_id
			erb :'/images/new'
		else 
			redirect to "/login"
		end
	end 

	post '/images/new' do 
		@image = Image.new(filename: params[:image][:filename], image_name: params[:image][:image_name], description: params[:image][:description])
		@user = current_user
      	@image.user_id = @user.id
      	@image.save
      	@user.images << @image
      	File.open("./public/image/#{@image.filename}", 'w') do |f|
        	f.write(params[:image][:tempfile].read)
        redirect to "/users/#{@user.slug}"
      	end
	end

	get '/images/:id' do
		if logged_in?
			@image = Image.find_by(id: params[:id])
			@user = current_user
			erb :'/images/show'
		else  
			redirect to "/login"
		end
	end

	get '/images/:id/edit' do
		@image = Image.find_by(id: params[:id])
		if logged_in? && current_user.id == @board.user_id
			@user = current_user
			erb :'/images/edit'
		else
			redirect to "/login"
		end
	end

	post '/images/:id/edit' do
		@image = Image.find_by(id: params[:id])
		@image.update(params[:image])
		redirect to "/images/#{@image.id}"
	end

	get '/images/:id/delete' do 
		@image = Image.find_by(id: params[:id])
		if logged_in? && current_user.id == @image.user_id
			@image.destroy
			@user = current_user
			redirect to "/users/#{@user.slug}"
		else 
			redirect to "/login"
		end
	end
 
end