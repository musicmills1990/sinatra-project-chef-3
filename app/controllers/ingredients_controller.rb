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
        @ingredient = current_user.ingredients.new(fridge_freezer_item: params[:fridge], pantry_item: params[:pantry], spice_cabinet_item: params[:spice])
        #how do I iterate over the 'clicked' ingredient objects' attributes and add them to the current_user's kitchen?
        if @ingredient.save
          flash[:message] = "Items successfully added. Nice!"
          redirect "/ingredients"
        else
          redirect "/ingredients/new"
        end
      end
    else
      flash[:errors] = "You must be logged in to add ingredients to your kitchen."
      redirect "/login"
    end
  end

  delete '/ingredients/:id/delete' do
    if logged_in?
      @ingredient = Ingredient.find_by_id(params[:id])
      if @ingredient && @ingredient.user == current_user
        @ingredient.delete
        flash[:message] = "ingredient successfully deleted!"
        redirect "/ingredients"
      else
        flash[:errors] = "You can't delete other peoples ingredients. Only your own."
        redirect "/ingredients"
      end
    else
      flash[:errors] = "If you're a hacker, go away. Otherwise, you should log in."
      rediret "/login"
    end
  end
end
