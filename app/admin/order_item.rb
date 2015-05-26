ActiveAdmin.register OrderItem do
  permit_params do
    permitted = [:order, :menu_item, :quantity]
    permitted
  end
end