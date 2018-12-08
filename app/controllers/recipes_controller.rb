class RecipesController < ApplicationController

  get '/recipes' do
    if logged_in?
      @recipes = Recipe.all
      erb :"recipes/index"
    else
      flash[:errors] = "Please log in to view recipes."
      redirect '/login'
    end
  end


  get '/recipes/new' do
    if logged_in?
      erb :"recipes/new"
    else
      flash[:errors] = "Please log in to add new recipes."
      redirect '/login'
    end
  end

  post '/recipes' do
    if logged_in?
      if params[:recipe_first_ingredient] == "" && params[:instructions] == ""
        flash[:errors] = "You must have at least one ingredient and recipe instructions to submit."
        redirect '/recipes/new'
      else
        @recipe = Recipe.new(content: params[:content], recipe_first_ingredient: params[:recipe_first_ingredient], recipe_second_ingredient: params[:recipe_second_ingredient], recipe_third_ingredient: params[:recipe_third_ingredient], recipe_fourth_ingredient: params[:recipe_fourth_ingredient], instructions: params[:instructions])
        if @recipe.save
          flash[:message] = "New Recipe Successfully added!"
          redirect "/recipes/#{@recipe.id}"
        else
          redirect '/recipes/new'
        end
      end
    else
      flash[:errors] = "You must be logged in to add a new recipe. Please log in."
      redirect '/login'
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      erb :"recipes/show"
    else
      flash[:errors] = "You have to be logged in to view this page. Please log in."
      redirect '/login'
    end
  end


end
