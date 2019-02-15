class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/fitness_classes'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(:name => params[:name], :email => params[:email], :username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/fitness_classes'
    end
  end

end
