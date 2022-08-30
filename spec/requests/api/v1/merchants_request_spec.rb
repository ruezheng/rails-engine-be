require 'rails_helper'

RSpec.describe "Merchants API" do
  describe 'GET /api/v1/merchants endpoint' do
    context 'happy path' do
      it 'sends all merchants and their attributes' do
        create_list(:merchant, 3)

        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(merchants.count).to eq(3)

        merchants.each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_a(String)
          expect(merchant).to_not have_key(:number_sold)
        end
      end
    end

    context 'sad path' do
      it "sends an empty array if no merchants exist" do
        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(merchants).to eq([])
      end
    end
  end

  describe 'GET /api/v1/merchant/:id endpoint' do
    context 'happy path' do
      it 'sends one merchant and their attributes by id' do
        id = create(:merchant).id

        get "/api/v1/merchants/#{id}"

        merchant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(merchant).to have_key(:id)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
        expect(merchant).to_not have_key(:number_sold)
      end
    end

    context 'sad path' do
      it "sends a 404 status if the id not valid" do
        get "/api/v1/merchants/1"

        expect(response.status).to eq(404)
      end
    end
  end
end
