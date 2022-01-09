class AddPreferenceIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :preference_id, :string
  end
end
