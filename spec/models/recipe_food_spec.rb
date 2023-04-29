require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(name: 'Juan Pablo', email: 'juanpa@gmail.com', password: '123456')
    @food = Food.create(name: 'tomato', measurement_unit: 'Units', price: 1, quantity: 10, user_id: @user.id)
    @recipe = Recipe.create(name: 'Pizza', description: 'Description to make pizza',
                            preparation_time: 0.2, cooking_time: 0.5, user_id: @user.id, public: false)
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: 2)
  end

  context 'Testing validations' do
    it 'Should be Valid' do
      expect(@recipe_food).to be_valid
    end

    it 'Recipe food should have a recipe' do
      expect(@recipe_food.recipe).to be_present
    end

    it 'Recipe food should validate iff recipe id exits' do
      @recipe_food.recipe = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'Recipe food should have a food' do
      expect(@recipe_food.food).to be_present
    end

    it 'Recipe food should validate iff food id exits' do
      @recipe_food.food = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'Recipe food should have a quantity' do
      expect(@recipe_food.quantity).to be_present
    end
  end

  context 'Testing associations' do
    it 'Recipe food should belong to a recipe' do
      @recipe_food = RecipeFood.reflect_on_association(:recipe)
      expect(@recipe_food.macro).to eq(:belongs_to)
    end

    it 'Recipe food should belong to a food' do
      @recipe_food = RecipeFood.reflect_on_association(:food)
      expect(@recipe_food.macro).to eq(:belongs_to)
    end
  end
end
