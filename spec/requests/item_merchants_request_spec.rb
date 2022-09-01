require 'rails_helper'

RSpec.describe 'Item Merchants API' do
  describe "Index: GET /api/v1/items/:items_id/merchants endpoint" do
    describe 'happy path' do
      it 'gets all merchants that have a specific item' do
        id = create(:item).id
        create_list(:merchant, 5, item_id: id)

        get "/api/v1/items/#{id}/merchants"
        
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
    
    describe 'sad path' do
      it 'returns a 404 status if merchant id is invalid' do
        id = create(:item).id + 1
        
        get "/api/v1/items/#{id}/merchants"

        expect(response.status).to eq(404)
      end
    end
  end
end