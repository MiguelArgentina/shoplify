class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :sales_conunt, :sales_count
  end
end
