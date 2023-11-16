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
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to items_path
    else
      flash.now[:alert] = 'Item update failed.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    flash[:notice] = 'Item deleted successfully.'
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :minimum_tickets, :batch_count, category_ids: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end

end