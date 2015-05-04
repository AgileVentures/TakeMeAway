class ChangeStartDateToDate < ActiveRecord::Migration
  def change
    change_column :menus, :start_date,  :date
    change_column :menus, :end_date,  :date
  end
end
