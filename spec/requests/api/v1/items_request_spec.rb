require 'rails_helper'

RSpec.describe "Items API" do

  describe 'GET /api/v1/items endpoint' do
    context 'happy path' do
      it 'gets all items and their attributes' do
        create_list(:item, 10)

        get '/api/v1/items'

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(items.count).to eq(10)

        items.each do |item|
          expect(item).to have_key(:id)
          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_a(String)
          expect(item[:attributes][:description]).to be_a(String)
          expect(item[:attributes][:unit_price]).to be_a(Float)
          expect(item[:attributes][:merchant_id]).to be_a(Integer)
          expect(item).to_not have_key(:number_sold)
        end
      end
    end
  end
end
