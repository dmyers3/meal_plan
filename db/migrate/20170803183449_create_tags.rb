class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, :taggable_type
      t.integer :user_id, :taggable_id
      t.timestamps
    end
  end
end
