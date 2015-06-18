ActiveAdmin.register Menu do
  permit_params :title, :start_date, :end_date,
                menu_items_menus_attributes: [:id, :menu_item_id, :daily_stock, :_destroy]

  scope 'Current week', :this_week, default: true
  scope :all

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
    column :end_date
    column 'Menu Items Count' do |menu|
      menu.menu_items_menus.count
    end
    actions
  end

  form do |f|
    f.inputs 'Menu Details' do
      f.input :title
      f.input :start_date, as: :date_time_picker, datepicker_options: {timepicker: false, format: 'Y-m-d'}
      f.input :end_date, as: :date_time_picker, datepicker_options: {timepicker: false, format: 'Y-m-d'}
    end
    f.has_many :menu_items_menus, allow_destroy: true do |item_form|
      item_form.input :menu_item, collection: MenuItem.all
      item_form.input :daily_stock, as: :number
    end
    f.actions
  end

  show title: proc { [params[:menu].title, params[:menu].start_date.strftime('%F')].join(' ') } do
    attributes_table do
      h3 'Menu Items'
      table_for params[:menu].menu_items_menus do
        column :name do |item|
          item.menu_item.name
        end
        column :daily_stock do |item|
          item.daily_stock
        end
        column :price do |item|
          item.menu_item.price
        end
      end
    end
  end
end
