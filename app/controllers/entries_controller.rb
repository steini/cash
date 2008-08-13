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
end
