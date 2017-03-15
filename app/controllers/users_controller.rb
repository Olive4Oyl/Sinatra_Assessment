class UsersController < ApplicationController

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	get '/signup' do
		if !logged_in? 
			erb :'/users/signup'
		else
			@user = current_user
			redirect to "/users/#{@user.slug}"
		end
	end 
	
	post '/signup' do
		if  params[:username] != "" && params[:email] != "" && params[:password] != ""
			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
			session[:id] = @user.id
			@user.save
			redirect to "/users/#{@user.slug}"
		else
			redirect to "/signup"
		end
	end

	get '/login' do 
		if logged_in?
			@user = current_user
			redirect to "/users/#{@user.slug}"
		end
		erb :'/users/login'
	end

	post '/login' do 
		@user = User.find_by(:username => params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect to "/users/#{@user.slug}"
		else 
			redirect to "/signup"
		end
	end

	get '/users/:slug' do 
		@user = User.find_by_slug(params[:slug])
		erb :'/users/home'
	end

	get '/logout' do 
  	if logged_in?
  		session.clear
  		redirect to "/login"
  	elsif !logged_in?
  		redirect to "/"
  	end
  end

end