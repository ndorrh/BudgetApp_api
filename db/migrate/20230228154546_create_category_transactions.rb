class CreateCategoryTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :category_transactions do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :my_transaction, null: false, foreign_key: true
      t.timestamps
    end
  end
end
