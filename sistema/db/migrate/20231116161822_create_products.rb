class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :Description
      t.string :Category
      t.integer :Amount
      t.float :PurchasePrice
      t.float :SalePrice
      t.string :Image

      t.timestamps
    end
  end
end
