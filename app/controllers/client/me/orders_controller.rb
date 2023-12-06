class Client::Me::OrdersController < ApplicationController
  before_action :authenticate_client_user!
  before_action :set_order, only: :update
  before_action :check_order_if_submitted, only: :update

  def index
    @orders = current_client_user.orders
  end
  def update
    if params[:commit] && params[:commit] == 'Cancel'
      if @order.cancel!
        flash[:notice] = 'Order cancelled.'
        redirect_to order_history_index_path
      else
        flash[:alert] = @order.errors.full_messages
        redirect_to order_history_index_path
      end
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def check_order_if_submitted
    return if @order.may_cancel?
    flash[:alert] = 'You do not have authorization.'
    redirect_to order_history_index_path
  end
end