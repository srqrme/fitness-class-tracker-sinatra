require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fitness_class_secret"
  end

# Route to Welcome page
  get "/" do
    if logged_in?
      redirect to '/fitness_classes'
    else
      erb :welcome
    end
  end

  helpers do

    # returns true or false based on the presence of a session[:user_id]
    def logged_in?
      !!current_user
    end

    # returns the instance of the logged in user, based on the session[:user_id]
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
