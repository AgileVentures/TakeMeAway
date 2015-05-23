ActiveAdmin.register MenuItem, as: 'Products' do

  permit_params :name, :price, :description, :ingredients, image_attributes: [:file]

  index do
    selectable_column
    #id_column
    column :name
    column :price
    actions
  end

  filter :name
  filter :price

  form html: { multipart: true } do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :price
      f.input :description
      f.input :ingredients
    end
    f.inputs 'Image', for: [:image, f.object.image || f.object.build_image] do |image_form|
      image_form.input :file, hint: !f.object.image.new_record? ? image_tag(f.object.image.file.url(:medium)) : content_tag(:span, "Upload JPG/PNG/GIF image")
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
        product.image ? image_tag(product.image.file.url(:medium)) : content_tag(:span, "No photo yet")
      end
    end
  end
end
