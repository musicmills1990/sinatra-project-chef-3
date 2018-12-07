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
end
