class Entry < ActiveRecord::Base
  
  has_one :category
  
  validates_presence_of         :title, :category_id, :amount
  validates_numericality_of     :amount
  
end
