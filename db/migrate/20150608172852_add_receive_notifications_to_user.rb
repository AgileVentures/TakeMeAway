class AddReceiveNotificationsToUser < ActiveRecord::Migration
  def change
    add_column :users, :receive_notifications, :boolean, default: false
  end
end
