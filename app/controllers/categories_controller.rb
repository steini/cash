class CategoriesController < ApplicationController

  before_filter :login_required
  
  def new
    @category = Category.new
    @categories = Category.find(:all)
  end
  
  def create
    @categories = Category.find(:all)
    @category = Category.new(params[:category])
    
    respond_to do |format|
      if @category.save
        flash[:success] = 'category was successfully created.'
        format.html { redirect_to new_category_url }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      flash[:success] = "category deleted"
      format.html { redirect_to new_category_url }
    end
  end
  
end
