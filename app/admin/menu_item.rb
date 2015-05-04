ActiveAdmin.register MenuItem, as: 'Products' do

  permit_params :name, :price, :description

  index do
    selectable_column
    #id_column
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
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :price
      row :description
    end
  end

end
