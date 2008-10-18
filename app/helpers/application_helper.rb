# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def balance_style income, spending
    
    if spending + income < 0 
      style = " style=\"color:red\""
    else
      style = " style=\"color:green\""
    end
    style
  end
  
  def balance_style_by_amount amount
    amount >= 0 ? " style=\"background-color:green;text-align:right\"" : " style=\"background-color:red;text-align:right\""
  end
  
end
