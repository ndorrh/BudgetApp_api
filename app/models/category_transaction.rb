class CategoryTransaction < ApplicationRecord
  belongs_to :my_transaction
  belongs_to :category
end
