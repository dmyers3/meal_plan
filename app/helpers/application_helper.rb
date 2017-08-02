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
end
