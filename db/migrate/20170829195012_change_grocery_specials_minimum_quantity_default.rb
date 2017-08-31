class ChangeGrocerySpecialsMinimumQuantityDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :grocery_specials, :minimum_quantity, :integer, default: 1
  end
end
