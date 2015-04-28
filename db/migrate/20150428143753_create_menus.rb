class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.boolean :show_category
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
