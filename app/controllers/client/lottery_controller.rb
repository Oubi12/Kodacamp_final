class Client::LotteryController < ApplicationController
  before_action :set_item, only: :show

  def index
    @categories = Category.all

    if params[:commit].present? && params[:commit] != 'all'
      @category = Category.find_by_name(params[:commit])

      if @category
        @items = @category.items.starting.limit(4)
      else
        flash[:alert] = "Category '#{params[:commit]}' not found."
        @items = []
      end
    else
      @items = Item.starting.includes(:categories).limit(4)
    end
  end

  def show
    total_tickets = Ticket.where(item: @item, batch_count: @item.batch_count).count
    @progress = ((total_tickets / @item.minimum_tickets.to_f) * 100).round(2)
    @progress >= 100 ? @progress = 100 : @progress
    @user_tickets = Ticket.where(user: current_client_user,
                                 item: @item, batch_count: @item.batch_count)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end

