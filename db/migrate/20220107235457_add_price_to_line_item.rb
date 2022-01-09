class AddPriceToLineItem < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :price, :integer
  end
end
