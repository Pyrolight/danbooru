class BansController < ApplicationController
  before_filter :moderator_only, :except => [:show, :index]
  
  def new
    @ban = Ban.new
  end
  
  def edit
    @ban = Ban.find(params[:id])
  end
  
  def index
    @search = Ban.search(params[:search])
    @bans = @search.paginate(params[:page])
  end
  
  def show
    @ban = Ban.find(params[:id])
  end
  
  def create
    @ban = Ban.new(params[:ban])
    @ban.banner_id = CurrentUser.id
    
    if @ban.save
      redirect_to ban_path(@ban), :notice => "Ban created"
    else
      render :action => "new"
    end
  end
  
  def update
    @ban = Ban.find(params[:id])
    if @ban.update_attributes(params[:ban])
      redirect_to ban_path(@ban), :notice => "Ban updated"
    else
      render :action => "edit"
    end
  end  
  
  def destroy
    @ban = Ban.find(params[:id])
    @ban.destroy
    redirect_to bans_path, :notice => "Ban destroyed"
  end
end
