class FitnessClassesController < ApplicationController

  get '/fitness_classes' do
    if logged_in?
      @fitness_classes = current_user.fitness_classes.all
      erb :'fitness_classes/classes'
    else
      redirect to '/login'
    end
  end

end
