class Category < ApplicationRecord
  has_many :category_transactions, dependent: :destroy
  has_many :my_transactions, through: :category_transactions, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true
end
