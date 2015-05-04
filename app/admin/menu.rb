ActiveAdmin.register Menu do
  permit_params :title, :start_date, :end_date,
                menu_item_ids: []

  controller do
    def show
      params[:menu] = Menu.find(params[:id])
    end

  end

  index do
    selectable_column
    #id_column
    column :title
    column :start_date
    actions
  end

  form do |f|
    f.inputs 'Menu Details' do
      f.input :title
      f.input :start_date, as: :date_time_picker, datepicker_options: {format: 'Y-m-d'}
      f.input :end_date, as: :date_time_picker, datepicker_options: {format: 'Y-m-d'}
      f.inputs 'Menu Items' do
        f.input :menu_items, as: :select, input_html: {multiple: true}
      end

    end
    f.actions
  end

  show title: proc{ [ params[:menu].title, params[:menu].start_date.strftime('%F') ].join(' ') } do
    attributes_table do
      h3 'Menu Items'
      table_for params[:menu].menu_items do
        column :name
        column :price
      end
    end
  end
end
