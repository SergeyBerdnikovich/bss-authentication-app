class AddTwoStepAuthToUser < ActiveRecord::Migration
  def change
    add_column :users, :two_step_auth, :boolean
  end
end
