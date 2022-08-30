require 'rails_helper'

RSpec.describe "Items API" do

  describe 'GET /api/v1/items endpoint' do
    context 'happy path' do
      it 'gets all items and their attributes' do
        id = create(:merchant).id
        create_list(:item, 5, merchant_id: id)

        get '/api/v1/items'

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(items.count).to eq(5)

        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_a(String)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_a(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_a(Float)

          expect(item[:attributes]).to have_key(:merchant_id)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)

          expect(item).to_not have_key(:number_sold)
        end
      end
    end
  end
end
