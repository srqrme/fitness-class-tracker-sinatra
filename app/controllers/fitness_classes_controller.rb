class FitnessClassesController < ApplicationController

  get '/fitness_classes' do
    if logged_in?
      @fitness_classes = current_user.fitness_classes.all
      erb :'fitness_classes/index'
    else
      redirect to '/login'
    end
  end

  get '/fitness_classes/new' do
    if logged_in?
      erb :'fitness_classes/new'
    else
      redirect to '/login'
    end
  end

  post '/fitness_classes' do
    if params[:name] == "" ||
      params[:date] == "" ||
      params[:time] == "" ||
      params[:location] == "" ||
      params[:instructor] == ""
      redirect to "/fitness_classes/new"
    else
      @fitness_class = current_user.fitness_classes.create(name: params[:name],
      date: params[:date],
      time: params[:time],
      location: params[:location],
      instructor: params[:instructor])
      @fitness_class.save
      redirect to "/fitness_classes/#{@fitness_class.id}"
    end
  end

  get '/fitness_classes/:id' do
    if logged_in?
      @fitness_class = FitnessClass.find_by_id(params[:id])
      if @fitness_class.user_id == current_user.id
        erb :'/fitness_classes/show'
      else
        redirect to "/fitness_classes"
      end
    else
      redirect to '/login'
    end
  end

  get '/fitness_classes/:id/edit' do
    if logged_in?
      @fitness_class = FitnessClass.find_by_id(params[:id])
      if @fitness_class.user_id == current_user.id
        erb :'/fitness_classes/edit'
      else
        redirect to "fitness_classes"
      end
    else
      redirect to '/login'
    end
  end

  patch '/fitness_classes/:id' do
    if logged_in?
      if params[:date] == "" || params[:time] == "" || params[:location] == "" || params[:instructor] == ""
        redirect to "/fitness_classes/#{params[:id]}/edit"
      else
        @fitness_class = FitnessClass.find_by_id(params[:id])
        if @fitness_class.user_id = current_user.id
          @fitness_class.update(date: params["date"], time: params["time"], location: params["location"], instructor: params["instructor"])
          redirect to "/fitness_classes/#{@fitness_class.id}"
        else
          redirect to "/fitness_classes"
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/fitness_classes/:id/delete' do
    if logged_in?
      @fitness_class = FitnessClass.find_by_id(params[:id])
      if @fitness_class.user_id == current_user.id
        @fitness_class.delete
        redirect to '/fitness_classes'
      end
    else
      redirect to '/login'
    end
  end
end
