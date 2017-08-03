class AddTagCategoryIdToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :tag_category_id, :integer
    remove_column :tags, :name
  end
end
