class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
end
