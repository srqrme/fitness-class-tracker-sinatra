class FitnessClassesController < ApplicationController

  # index action: display all fitness_classes
  get '/fitness_classes' do
    if logged_in?
      @fitness_classes = current_user.fitness_classes.all
      erb :'fitness_classes/index'
    else
      redirect to '/login'
    end
  end

  # new action: display create fitness class form
  get '/fitness_classes/new' do
    if logged_in?
      erb :'fitness_classes/new'
    else
      redirect to '/login'
    end
  end

  #create action: creates one fitness class
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

  # show action: displays one fitness class based on ID in URL
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

  # edit action: displays edit form based on ID in URL
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

  # update action: modifies an existing fitness class based on ID in the URL
  patch '/fitness_classes/:id' do
    if logged_in?
      if params[:date] == "" || params[:time] == "" || params[:location] == "" || params[:instructor] == ""
        redirect to "/fitness_classes/#{params[:id]}/edit"
      else
        @fitness_class = FitnessClass.find_by_id(params[:id])
        if @fitness_class.user_id = current_user.id
          @fitness_class.update(date: params["date"], time: params["time"], location: params["location"], instructor: params["instructor"])
          @fitness_class.save
          redirect to "/fitness_classes"
        end
      end
    else
      redirect to '/login'
    end
  end

  # delete action: deletes one class based on ID in URL
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
