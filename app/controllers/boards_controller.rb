require 'pry'
class BoardsController < UsersController

	get '/boards' do
		@boards = Board.all
		erb :'/boards/index'
	end 

	get '/boards/new' do 
		if !logged_in?
			redirect to "/login"
		end
		erb :'/boards/new'
	end

	post '/boards/new' do 
		@user = User.find_by(session[:id])
		@board = Board.create(params[:board])
		@board.user_id = @user.id
		@board.save
		redirect to "/boards/#{@board.id}"
	end

	get '/boards/:id' do 
		@board = Board.find_by(id: params[:id])
		@user = current_user
		@board.user_id = @user.id
		@board.save
		erb :'/boards/show'
	end

	get '/boards/:id/edit' do 
		@user = current_user
		if logged_in?
			@board = Board.find_by(id: params[:id])
			erb :'/boards/edit'
		else
			redirect to "/login"
		end
	end

	post '/boards/:id/edit' do 
		@board = Board.find_by(params[:id])
		@board.update(params[:board])
		@board.save
		redirect to "/boards/#{@board.id}"
	end

	get '/boards/:id/delete' do 
		@board = Board.find_by(params[:id])
		if logged_in? && current_user.id == @board.user_id
			@board.destroy
			@user = current_user
			redirect to "/users/#{@user.slug}"
		end
	end


	# get '/boards/:slug' do 
	# 	@user = Board.find_by_slug(params[:slug])

	# end



end