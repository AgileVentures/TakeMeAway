ActiveAdmin.register MenuItem, as: 'Products' do
  
  controller do
    helper :menu_item
  end

  permit_params :name, :price, :description, :ingredients, :image, :status

  config.sort_order = 'status_asc'
  
  index do
    selectable_column
    #id_column
    column :name
    column :price
    column :status do |menu_item|
      status_tag(menu_item.status, menu_item_status_color(menu_item))
    end
    actions
  end

  filter :name
  filter :price
  filter :status, as: :select

  form html: { multipart: true } do |f|
    f.inputs 'Product Details' do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :price
      f.input :description, :input_html => {rows: 5}
      f.input :ingredients
      f.input :image, :as => :formtastic_attachinary
      f.input :status, as: :select, collection: MenuItem::STATUS, 
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
