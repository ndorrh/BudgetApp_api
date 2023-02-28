class MyTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :category_transactions, dependent: :destroy
  has_many :categories, through: :category_transactions

   validates :name, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
