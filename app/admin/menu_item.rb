ActiveAdmin.register MenuItem, as: 'Products' do

  permit_params :name, :price, :description, :ingredients, :image, :status

  index do
    selectable_column
    #id_column
    column :name
    column :price
    column :status
    actions
  end

  filter :name
  filter :price
  filter :status, as: :select

  form html: { multipart: true } do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :price
      f.input :description, :input_html => {rows: 5}
      f.input :ingredients
      f.input :image, :as => :formtastic_attachinary
      f.input :status, as: :select, collection: MenuItem.status_values, 
                    include_blank: false
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :name
      row :price
      row :description
      row :ingredients
      row :image do
        product.image.present? ? cl_image_tag(product.image.path, { width: 300, height: 300, crop: :fit }) : content_tag(:span, "No photo yet")
      end
      row :status
    end
  end
end
