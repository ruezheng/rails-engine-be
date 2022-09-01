class Api::V1::MerchantItemsController < ApplicationController

  def index
    if Merchant.exists?(params[:merchant_id])
      items = Merchant.find(params[:merchant_id]).items
      render json: ItemSerializer.new(items)
    else
      message = { error: 'Merchant does not exist' }
      render json: message.to_json, status: 404
    end
  end
end
