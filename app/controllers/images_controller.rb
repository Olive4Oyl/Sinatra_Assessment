require 'pry'
class ImagesController < UsersController

	# get '/images' do 
	# 	@images = Image.all
	# 	erb :'/images/index'
	# end 

	get '/images/new' do 
		if !logged_in?
			redirect to "/login"
		end
		erb :'/images/new'
	end 

	post '/images/new' do 
		
		@image = Image.new(filename: params[:image][:filename])
		@user = current_user
      	@image.user_id = @user.id
      	@image.save
      	@user.images << @image
      	File.open("./public/image/#{@image.filename}", 'w') do |f|
        	f.write(params[:image][:tempfile].read)
        redirect to "/users/#{@user.slug}"
      end
		# @image = Image.new(filename: params[:file][:filename], description: "needs one", name: 'name', user_id: 1)
		# # image.filename = params[:file][:filename]
		# # image.description = params[:description]
		# @image.save
		# redirect to "images/#{@image.id}"
	end

	get '/images/:id' do
		@image = Image.find_by(id: params[:id])
		# erb :'/images/show'
	end

	# post '/images/new' do 
	# 	@user = current_user
	# 	if params[:image]
	# 	@image = Image.new(filename: params[:image][:filename])
	# 	@image.user_id = @user.id 
	# 	@image.save
	# 	File.open("./public/image/#{@image.file_name}", 'w') do |f|
 #        	f.write(params[:image][:tempfile].read)
 #        	binding.pry
 #    	end
 #    end
		
	# end
 
end