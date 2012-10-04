ActiveAdmin.register User do
  index do
    column :login
    column :email
    column :full_name
    column :password_digest
    column :two_step_auth
    column :created_at
    column :updated_at
  end
end
