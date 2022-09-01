require 'rails_helper'

RSpec.describe 'Merchant Items API' do
  describe "Index: GET /api/v1/merchants/:merchant_id/items endpoint" do
    describe 'happy path' do
      it 'gets all items that are associated with a merchant' do
        id = create(:merchant).id
        create_list(:item, 3, merchant_id: id)

        get "/api/v1/merchants/#{id}/items"

        merchant_items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(merchant_items.count).to eq(3)

        merchant_items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to eq('item')

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)

          expect(item).to_not have_key(:created_at)
          expect(item).to_not have_key(:updated_at)
        end
      end
    end

    describe 'sad path' do
      it 'returns a 404 status if merchant id is invalid' do
        id = create(:merchant).id + 1

        get "/api/v1/merchants/#{id}/items"

        expect(response.status).to eq(404)
      end
    end
  end
end
