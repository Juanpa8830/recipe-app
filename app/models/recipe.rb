class Recipe < ApplicationRecord
    has_many :recipe_foods, foreign_key: 'recipe_id', dependent: :destroy
    belongs_to :user, class_name: 'User'
    
    validates :name, presence: true
    validates :preparation_time, presence: true
    validates :cooking_time, presence: true
    validates :description, presence: true
    
    
    def total_price
        total=0
        recipe_foods.each do |rfood|
            total+= rfood.quantity * rfood.food.price
    end
    total
    end
    
    end