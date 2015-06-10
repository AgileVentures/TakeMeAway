ActiveAdmin.register User, as: 'Admins' do
  #scope :clients
  #scope :admins
  scope_to do
    User.admins
  end
  permit_params :email, :password, :password_confirmation, 
                :name, :is_admin, :receive_notifications, 
                :order_acknowledge_email
  
  # the following controller override allows user to edit admin resources
  # without re-entering the password (and confirmation) for every update
  # http://stackoverflow.com/questions/15292247/activeadmin-how-to-leave-user-password-unchanged
  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
                  
  index do
    selectable_column
    #id_column
    column :name
    column :email
    column :receive_notifications
    column "Send 'Order Received' Email", :order_acknowledge_email
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
      f.input :is_admin
      f.input :receive_notifications
      f.input :order_acknowledge_email, label: 'Use this email address to send order acknowledgement to the customer'
    end
    f.actions
  end

end