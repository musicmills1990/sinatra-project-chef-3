#adds edit and delete protection back in
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
      @recipes = Recipe.all
      erb :"recipes/new"
    else
      flash[:errors] = "Please log in to add new recipes."
      redirect '/login'
    end
  end

  get '/recipes/your_recipes' do
    if logged_in?
      @recipes = Recipe.all
      erb :"recipes/user_show"
    else
      flash[:errors] = "Please log in to view your recipes."
      redirect '/login'
    end
  end

  post '/recipes' do
    if logged_in?
      if params[:recipe_first_ingredient] == "" && params[:instructions] == ""
        flash[:errors] = "You must have at least one ingredient and recipe instructions to submit."
        redirect '/recipes/new'
      else
        @recipe = current_user.recipes.new(content: params[:content], recipe_first_ingredient: params[:recipe_first_ingredient], recipe_second_ingredient: params[:recipe_second_ingredient], recipe_third_ingredient: params[:recipe_third_ingredient], recipe_fourth_ingredient: params[:recipe_fourth_ingredient], instructions: params[:instructions])
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

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe && @recipe.user == current_user
        erb :"recipes/edit"
      else
        flash[:errors] = "You can only edit your own recipes"
        redirect "/recipes"
      end
    else
      flash[:errors] = "You have to be logged in to view this page. Please log in."
      redirect '/login'
    end
  end

  patch '/recipes/:id' do
    if logged_in?
      if params == "" || params == " "
        flash[:errors] = "You can't empty out a recipe"
        redirect "recipe/#{params[:id]}/edit"
      else
        @recipe = Recipe.find_by_id(params[:id])
        if @recipe && @recipe.user == current_user
          if @recipe.update(content: params[:content], recipe_first_ingredient: params[:recipe_first_ingredient], recipe_second_ingredient: params[:recipe_second_ingredient], recipe_third_ingredient: params[:recipe_third_ingredient], recipe_fourth_ingredient: params[:recipe_fourth_ingredient], instructions: params[:instructions])
            flash[:message] = "Recipe successfully updated!"
            redirect "/recipes/#{@recipe.id}"
          else
            flash[:errors] = "You can't empty out a recipe."
            redirect "/recipes/#{@recipe.id}/edit"
          end
        else
          flash[:errors] = "You can only edit your own recipes"
          redirect "/recipes"
        end
      end
    else
      flash[:errors] = "You have to be logged in to view this page. Please log in."
      redirect "/login"
    end
  end



  delete '/recipes/:id/delete' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe && @recipe.user == current_user
        @recipe.delete
        flash[:message] = "recipe successfully deleted!"
        redirect "/recipes"
      else
        flash[:errors] = "You can't delete other peoples recipes. Only your own."
        redirect "/recipes"
      end
    else
      flash[:errors] = "If you're a hacker, go away. Otherwise, you should log in."
      rediret "/login"
    end
  end
end
