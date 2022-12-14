require 'rails_helper'

RSpec.describe "Merchants API" do

  describe 'GET /api/v1/merchants endpoint' do
    context 'happy path' do
      it 'gets all merchants and their attributes' do
        create_list(:merchant, 3)

        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(merchants.count).to eq(3)

        merchants.each do |merchant|
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
    end
    
    context 'sad path' do
      it "returns an empty array if no merchants exist" do
        get '/api/v1/merchants'
        
        merchants = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(response.status).to eq(200)
        expect(merchants).to eq([])
      end
    end
  end
  
  describe 'GET /api/v1/merchant/:id endpoint' do
    context 'happy path' do
      it 'gets one merchant and their attributes by id' do
        id = create(:merchant).id
        
        get "/api/v1/merchants/#{id}"
        
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
    
    context 'sad path' do
      it "returns a 404 status if the id is not valid" do
        get "/api/v1/merchants/1"
        
        expect(response.status).to eq(404)
      end
    end
  end
end
