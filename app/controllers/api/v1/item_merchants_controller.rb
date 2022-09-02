class ItemMerchantsController < ApplicationController

  def index
    if Item.exists?(params[:item_id])
      require pry; binding.pry
      item = Item.find(params[:item_id])
      MerchantSerializer.new(item.merchants)
    else
      render status: 404
    end
  end
end