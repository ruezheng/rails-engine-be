require 'rails_helper'

RSpec.describe 'Item Merchants API' do
  describe "Index: GET /api/v1/items/:items_id/merchant endpoint" do
    describe 'happy path' do
      it 'gets a merchant associated with a specific item by item_id' do
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)

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
      xit 'returns a 404 status if item id is invalid' do
        id = create(:item).id + 1

        get "/api/v1/items/#{id}/merchant"

        expect(response.status).to eq(404)
      end
    end
  end
end