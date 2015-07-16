ActiveAdmin.register MenuItem, as: 'Products' do
  
  controller do
    helper :menu_item
  end
  
  batch_action :destroy, confirm: 'Delete selected items (that can be deleted)?' do |items|
    delete_count = 0
    MenuItem.find(items).each do |item|
      if item.can_menu_item_be_destroyed?
        delete_count += 1
        MenuItem.destroy(item)
      end
    end
    flash[:notice] = "Deleted #{delete_count.to_s} #{'product'.pluralize(delete_count)}."
    redirect_to admin_products_path
  end

  permit_params :name, :price, :description, :ingredients, :image, :status

  config.sort_order = 'status_asc'
  
  index do
    selectable_column
    column :name
    column :price
    column :status do |item|
      status_tag(item.status, menu_item_status_color(item))
    end
    column :actions do |item| 
      links = link_to I18n.t('active_admin.view'), admin_product_path(item)
      if item.can_menu_item_be_destroyed?
        links += link_to "Delete", admin_product_path(item), :method => :delete, 
                data: {confirm: 'Are you sure?'}
      end
      links += link_to I18n.t('active_admin.edit'), edit_admin_product_path(item)
    end
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
