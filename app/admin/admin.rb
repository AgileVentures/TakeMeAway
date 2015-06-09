ActiveAdmin.register User, as: 'Admins' do
  #scope :clients
  #scope :admins
  scope_to do
    User.admins
  end
  permit_params :email, :password, :password_confirmation, 
                :name, :receive_notifications, :is_admin


  index do
    selectable_column
    #id_column
    column :name
    column :email
    column :receive_notifications
    column 'Member since', :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :receive_notifications
      f.input :is_admin
    end
    f.actions
  end

end