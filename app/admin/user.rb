ActiveAdmin.register User, as: 'Clients' do
  #scope :clients
  #scope :admins
  scope_to do
    User.clients
  end
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    # id_column
    column :name
    column :email
    column 'Joined at', :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
    end
    f.actions
  end
end
