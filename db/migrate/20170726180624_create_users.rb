class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, :password_digest, :token
      t.boolean :paid_member?, default: false
      t.timestamps
    end
  end
end
