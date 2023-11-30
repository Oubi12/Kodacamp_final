class Client::Me::LotteriesController < ApplicationController
  before_action :authenticate_client_user!
  def index
    @lotteries = current_client_user.tickets
  end
end