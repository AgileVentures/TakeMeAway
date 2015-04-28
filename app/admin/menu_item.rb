ActiveAdmin.register MenuItem, as: 'Products' do

  permit_params :name, :price

  index do
    selectable_column
    id_column
    column :name
    column :price
    actions
  end

  filter :name
  filter :price
  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :price
    end
    f.actions
  end

end