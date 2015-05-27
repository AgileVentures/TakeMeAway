class AddDefaultToUserIsAdmin < ActiveRecord::Migration
  def up
    change_column :users, :is_admin, :boolean, default: false
    is_admin_from_nil_to_false
    test_changes
  end

  def down
    change_column :users, :is_admin, :boolean
  end

  private

  def is_admin_from_nil_to_false
    User.find_each do |user|
      user.update_attributes(is_admin: false) if user.is_admin == nil
    end
  end

  def test_changes
    User.find_each do |nil_user|
      if nil_user.is_admin == nil
        raise StandardError, "Migration could not change all users with 'is_admin: nil' to 'is_admin: false'"
      end
    end
  end
end
