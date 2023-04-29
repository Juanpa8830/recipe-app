class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe_food = RecipeFood.new
    @recipe_food.recipe_id = params[:recipe_id]
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    recipe = @recipe_food.recipe
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_path(recipe), notice: 'recipe_food deleted successfully' }
    end
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]

    if @recipe_food.save
      redirect_to recipe_path(params[:recipe_id]), notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
