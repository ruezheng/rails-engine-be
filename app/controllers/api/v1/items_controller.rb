class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render json: { error: item.errors.full_messages.to_sentence }, status: 404
    end
  end

  def update
    item = Item.update(params[:id], item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 200
    else
      render status: 404
    end
  end

  def destroy
    if Item.exists?(params[:id])
      Item.destroy(params[:id])
    else
      render status: 404
    end
  end

  def find
    item = Item.where("lower(name) like ?", "%#{params[:name].downcase}%").first
    if item != nil
      render json: ItemSerializer.new(item)
    else
      render json: { data: { error: 'No results found' } }, status: 204
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
