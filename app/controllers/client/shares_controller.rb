class Client::SharesController < ApplicationController
  def index
    @shares = Winner.where(state: :published).includes(:user)
  end
end