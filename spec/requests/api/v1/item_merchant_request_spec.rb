require 'rails_helper'

RSpec.describe 'Item Merchant API' do
  describe "Index: GET /api/v1/items/:items_id/merchant endpoint" do
    describe 'happy path' do
      it 'gets a merchant associated with a specific item by item_id' do
        id = create(:merchant).id
        item = create(:item, merchant_id: id)

        get "/api/v1/items/#{item.id}/merchant"

        merchant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant')

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)

        expect(merchant).to_not have_key(:created_at)
        expect(merchant).to_not have_key(:updated_at)
      end
    end

    describe 'sad path' do
      it 'returns a 404 status if item id is invalid' do
        get "/api/v1/items/1/merchant"

        expect(response.status).to eq(404)
      end
    end
  end
end
