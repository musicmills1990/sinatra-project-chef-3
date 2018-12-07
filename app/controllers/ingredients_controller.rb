class IngredientsController < ApplicationController

  get '/ingredients' do
    if logged_in?
      @ingredients = Ingredient.all
      erb :"ingredients/index"
    else
      redirect "/login"
    end
  end

  get '/ingredients/new' do
    if logged_in?
      @ingredients = Ingredient.all
      erb :"ingredients/new"
    else
      redirect "/login"
    end
  end

  post '/ingredients' do
    if logged_in?
      if params == ""
        flash[:error] = "You surely must have at least one thing in your kitchen. Please add some items."
        redirect "/ingredients/new"
      else
        @ingredient = current_user.ingredients.new(fridge_freezer_item: params[:fridge_1], pantry_item: params[:pantry_1], spice_cabinet_item: params[:spice_1])
        if @ingredient.save
          flash[:message] = "Items successfully added. Nice!"
          redirect "/ingredients/#{@ingredient.id}"
        else
          redirect "/ingredients/new"
        end
      end
    else
      flash[:errors] = "You must be logged in to add ingredients to your kitchen."
      redirect "/login"
    end
  end

  get "/ingredients/:id" do
    if logged_in?
      @ingredient = Ingredient.find_by(params[:id])
      erb :"ingredients/show"
    else
      flash[:errors] = "You have to be logged in to view your Kitchen Ingredients List. Please log in."
      redirect "/login"
    end
  end
end
