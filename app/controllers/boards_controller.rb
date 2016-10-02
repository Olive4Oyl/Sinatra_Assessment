require 'pry'
class BoardsController < ApplicationController

	# get '/boards' do
	# 	@boards = Board.all
	# 	erb :'/boards/index'
	# end 

	get '/boards/new' do 
		if logged_in? 
			erb :'/boards/new'
		else 
			redirect to "/login"
		end
	end

	post '/boards/new' do 
		@user = User.find_by(id: session[:id])
		@board = Board.create(params[:board])
		@board.user_id = @user.id
		@board.save
		redirect to "/boards/#{@board.id}"
	end

	get '/boards/:id' do 
		if logged_in?
			@board = Board.find_by(id: params[:id])
			@user = current_user
			erb :'/boards/show'
		else 
			redirect to "/login"
		end
	end

	get '/boards/:id/edit' do 
		@board = Board.find_by(id: params[:id])
		if logged_in? && current_user.id == @board.user_id
			@user = current_user
			erb :'/boards/edit'
		else
			redirect to "/login"
		end
	end

	post '/boards/:id/edit' do 
		@board = Board.find_by(id: params[:id])
		@board.update(params[:board])
		redirect to "/boards/#{@board.id}"
	end

	get '/boards/:id/image' do
		@board = Board.find_by(id: params[:id])
		if logged_in? && current_user.id == @board.user_id
			erb :'/boards/board_image_new'
		else 
			redirect to "/login"
		end
	end

	post '/boards/:id/image' do 
		@board = Board.find_by(id: params[:id])
		@image = Image.new(filename: params[:image][:filename], image_name: params[:image][:image_name], description: params[:image][:description])
		@image.board_ids << @board.id
		@board.images << @image
		@user = current_user
		@image.user_id = @user.id
		@board.save
		File.open("./public/image/#{@image.filename}", 'w') do |f|
        	f.write(params[:image][:tempfile].read)
        	redirect to "/boards/#{@board.id}"
        end
	end

	# get '/boards/images/:id/edit' do
	# 	@board = Board.find_by(id: params[:id])
	# 	@image_arr = @board.images
	# 	if logged_in? && current_user.id == @board.user_id
	# 		erb :'/boards/board_image_edit'
	# 	else 
	# 		redirect to "/login"
	# 	end
	# end

	# post '/boards/:id/image/edit' do 
	# 	@board = Board.find_by(id: params[:id])
	# 	binding.pry
	# 	@board.images.update(params[:image])
	# 	redirect to "/boards/#{@board.id}"
	# end

	# post '/images/:id/delete' do
 #    @image = Image.find_by_id(params[:id])
 #    binding.pry
 #     if logged_in? && current_user.id == @image.user_id

 #     	@user = current_user
 #        @image.destroy
 #        redirect to "/users/#{@user.slug}"
 #     end
 #   end

	# get '/boards/image/:id/delete' do 
	# 	@image = Image.find_by(id: params[:id])
	# 	binding.pry
	# 	@image.board_ids.find(id: params[:id])
	# 	# if logged_in? && current_user.id == @board.user_id
	# 	# 	@board.destroy
	# 	# 	@user = current_user
	# 	# 	redirect to "/users/#{@user.slug}"
	# 	# else 
	# 	# 	redirect to "/login"
	# 	# end
	# end


	# @board = Board.find_by(id: params[:id])
	# 	@image = Image.new(filename: params[:image][:filename], image_name: params[:image][:image_name], description: params[:image][:description])
	# 	@image.board_ids << @board.id
	# 	@board.images << @image
	# 	@board.save
	# 	File.open("./public/image/#{@image.filename}", 'w') do |f|
 #        	f.write(params[:image][:tempfile].read)
 #        	redirect to "/boards/#{@board.id}"
 #        end

	get '/boards/:id/delete' do 
		@board = Board.find_by(id: params[:id])
		if logged_in? && current_user.id == @board.user_id
			@board.destroy
			@user = current_user
			redirect to "/users/#{@user.slug}"
		else 
			redirect to "/login"
		end
	end

end