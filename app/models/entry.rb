class Entry < ActiveRecord::Base
  
  belongs_to :category
  belongs_to :user
  
  validates_presence_of         :title, :category_id, :amount
  validates_numericality_of     :amount

end
