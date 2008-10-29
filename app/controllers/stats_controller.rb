class StatsController < ApplicationController
  
  before_filter :login_required
  
  def index
    
    clause = ""
    
    sql = "select concat(month(date), \"/\", year(date)) as date, " +
      "sum(amount) as amount from entries %s group by month(date), " +
      "year(date) order by year(date) DESC, month(date) DESC;"
    
    clauses = {
      :spendings => "WHERE amount < 0", 
      :incomes => "WHERE amount > 0", 
      :sum => ""
    }
    
    @data = []
    
    clauses.each do |type, clause|
      results = ActiveRecord::Base.connection.select_all(sql % [clause], ["date", "amount"])
      results.each_with_index do |row, i|
        @data[i] =  {} if @data[i].nil?
        row.each do |key, value|
          if !@data[i].include?(key) && key == "date"
            @data[i][key] = value
            next
          end
          @data[i]["#{type.to_s}"] = value if key != "date"
          
        end
      end
    end
    
  end
  
end
