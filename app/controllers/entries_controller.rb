class EntriesController < ApplicationController

  require 'date'
  
  before_filter :login_required

  def index

    @entry = Entry.new
    @entry.amount = "-"

    @categories = Category.find(:all)

    if params.include?(:date)
      
      date_parts = params[:date].split("-")

      begin
        @date = Date.new(date_parts[0].to_i, date_parts[1].to_i, 1)
        @entry.date = @date
        @entries = Entry.find(:all, :conditions => ["month(date) = ? and year(date) = ?", @date.month, @date.year], :order => "date DESC, updated_at DESC")
      rescue Exception => e
        logger.error e
        @entries = []
      end

    else
      @entries = []
    end

    render :template => "entries/list"
  end

  def new
    @entry = Entry.new
    @entry.amount = "-"
    @categories = Category.find(:all)
  end
  
  def create

    params[:entry][:amount] = params[:entry][:amount].strip.gsub(/,/, ".").gsub(/ /, "")

    @entry = Entry.new(params[:entry])
    @categories = Category.find(:all)

    @entry.user_id = current_user.id

    respond_to do |format|
      if @entry.save
        flash[:success] = 'entry was successfully created.'
        format.html { redirect_to :back }
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
      format.html { redirect_to :back }
    end
  end
  
  def edit
    @entry = Entry.find(params[:id])
    @categories = Category.find(:all)
    
    respond_to do |format|
      format.html
      format.js { render :partial => "edit" }
    end
  end
  
  def update
    @entry = Entry.find(params[:id])
    return render(:action => :edit) unless @entry.update_attributes(params[:entry])
    
    respond_to do |format|
      flash[:notice] = "Successfully updated entry"
      format.html { redirect_to :controller => "home" }
      format.js { render :partial => "entry" }
    end
  end

  def cancel
    @entry = Entry.find(params[:id])
    respond_to do |format|
      format.html { render :partial => "entry" }
    end
  end

end
