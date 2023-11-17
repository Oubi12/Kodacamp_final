class Client::LotteryController < ApplicationController
  def index
    @categories = Category.all

    if params[:commit] != 'All' || !params[:commit].present?
      @category = Category.find_by_name(params[:commit])

      if @category
        @items = @category.items.limit(4)
      else
        flash[:alert] = "Category '#{params[:commit]}' not found."
        @items = []
      end
    else
      @items = Item.starting.includes(:categories).limit(4)
    end
  end
end

