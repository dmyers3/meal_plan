class ChangePaidMemberColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :paid_member?, :paid_member
  end
end
