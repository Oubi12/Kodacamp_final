class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to items_path
    else
      flash.now[:alert] = 'Item creation failed.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if params[:commit] == 'Start' && @item.start!
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    elsif params[:commit] == 'Pause' && @item.pause!
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    elsif params[:commit] == 'End' && @item.end!
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    elsif params[:commit] == 'Cancel' && @item.cancel!
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    elsif @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    else
      flash.now[:alert] = 'Item update failed.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = 'Category destroyed successfully'
    else
      flash[:alert] = @item.errors.full_messages.join(', ')
    end
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name,
                                 :quantity, :minimum_tickets,
                                 :start_at, :online_at, :offline_at,
                                 :status, category_ids: [])
  end

  def set_item

  end

  def set_item
    @item = Item.find(params[:id])
  end

end