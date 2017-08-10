module ApplicationHelper
  # used during plan signup to keep plan highlighted if page re-renders after error
  def plan_classes(plan)
    if params[:user]
      ["plan", ('highlight' if params[:user][:plan] == plan)]
    elsif plan == 'bronze'
      ["plan", 'highlight']
    else
      ['plan']
    end
  end
  
  # used during plan signup to keep plan checked if page re-renders after error
  def check_radio(plan)
    params[:user].try(:[], :plan) == plan
  end
  
  def ingredient_options
    Ingredient.all.map do |ingredient|
      [ingredient.name, ingredient.id]
    end
  end
  
  def recipe_units
    [
      ['Mass/Weight', ['oz', 'lb', 'mg', 'g', 'kg']],
      ['Volume', ['tsp', 'tbsp', 'fl oz', 'c', 'pt', 'qt', 'gal', 'ml', 'l']],
      ["Size", ["small", "medium", "large"]]
    ]
  end
end
