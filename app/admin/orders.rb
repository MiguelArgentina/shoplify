ActiveAdmin.register Order do

  permit_params :name, :email, :address,
    line_items_attributes: [:id, :name, :description, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :created_at
  end

  show do
    attributes_table do
      row :name
      row :email
      row :address
      table_for order.line_items.order('id ASC') do
        column "Line Items" do |line_item|
          link_to "Open line Item: #{line_item.id}", [:admin, line_item]
        end
      end
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :address
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :address]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
