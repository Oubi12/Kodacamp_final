class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_order, only: :update
  def index
    @orders = Order.all.includes(:user, :offer)
    @states = Order.aasm.states.map(&:name)
    @genres = Order.genres.keys
    @offers = Offer.all

    if params[:search].present?
      @orders = @orders.joins(:user).where("serial_number LIKE :search OR users.email LIKE :search", search: "%#{params[:search]}%")
    end

    if params[:start_date].present? && params[:end_date].present?
      start_date = params[:start_date]
      end_date = params[:end_date].to_date.end_of_day
      @orders = @orders.where(created_at: start_date..end_date)
    end

    if params[:state].present?
      @orders = @orders.where(state: params[:state])
    end

    if params[:genre].present?
      @orders = @orders.where(genre: params[:genre])
    end

    if params[:offer].present?
      @orders = @orders.where(offer_id: params[:offer])
    end

    @subtotal_amount = @orders.pluck(:amount).sum
    @total_amount = Order.sum(:amount)
    @subtotal_coins = @orders.pluck(:coin).sum
    @total_coins = Order.sum(:coin)
  end

  def update
    @order = Order.find(params[:id])

    if params[:commit] == 'Cancel'
      if @order.may_cancel?
        @order.cancel!
        flash[:notice] = 'Order canceled successfully.'
      end
    elsif params[:commit] == 'Pay'
      if @order.may_pay?
        if @order.pay!
          flash[:notice] = 'Order paid successfully.'
        else
          flash[:alert] = 'Failed to process payment for the order.'
        end
      end
    end

    redirect_to orders_path
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
