class EntriesController < ApplicationController
  
  before_filter :login_required
  
  def new
    @entry = Entry.new
    @categories = Category.find(:all)
  end
  
  def create
    @entry = Entry.new(params[:entry])
    @categories = Category.find(:all)

    @entry.user_id = current_user.id

    respond_to do |format|
      if @entry.save
        flash[:success] = 'entry was successfully created.'
        format.html { redirect_to new_entry_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      flash[:success] = "entry deleted"
      format.html { redirect_to :controller => "home" }
    end
  end
  
  def edit
    @entry = Entry.find(params[:id])
    @categories = Category.find(:all)
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @entry = Entry.find(params[:id])
    return render(:action => :edit) unless @entry.update_attributes(params[:entry])
    
    respond_to do |format|
      flash[:notice] = "Successfully updated entry"
      format.html { redirect_to :controller => "home" }
    end
  end
  
end
