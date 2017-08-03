class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name, :url
      t.integer :prep_time, :cook_time
      t.text :instructions
      t.timestamps
    end
  end
end
