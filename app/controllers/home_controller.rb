class HomeController < ApplicationController
  before_filter :login_required

  def index

    @entries = Entry.find(:all, :limit => 20, :order => "created_at DESC")
    
    @labels = []
    @incomes = []
    @spendings = []
    @diffs = []
    
    dates = []

    (0..11).each do |i|
      new_date = Date.today << i
      dates << Date.new(new_date.year, new_date.month, new_date.day)
    end

    dates.each do |date|
        @labels << date.month.to_s + "/" + date.year.to_s
        @incomes << Entry.sum(:amount, :conditions => ["amount > 0 and month(date) = ? and year(date) = ?", date.month, date.year])
        @spendings << Entry.sum(:amount, :conditions => ["amount < 0 and month(date) = ? and year(date) = ?", date.month, date.year])
        @diffs << @spendings.last + @incomes.last
    end
    
    @total_income = @incomes.inject(0) do |sum, income|
      sum + income
    end
    
    @total_spending = @spendings.inject(0) do |sum, spending|
      sum + spending
    end
    
  end

end
