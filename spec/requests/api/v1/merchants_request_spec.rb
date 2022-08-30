require 'rails_helper'

RSpec.describe "Merchants API" do
  describe 'index action' do
    context 'happy path' do
      it 'gets all merchants and their attributes' do
        create_list(:merchant, 3)
        
        get '/api/v1/merchants'
        
        expect(response.status).to eq(200)      
        
        merchants = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(merchants.count).to eq(3)
        
        merchants.each do |merchant|
          expect(merchant[:attributes]).to include(:id, :name) 
          expect(merchant[:attributes][:id]).to be_an(Integer) 
          expect(merchant[:attributes][:name]).to be_a(String) 
        end
      end
    end
    
    context 'sad path' do
      expect(response).to_not have_key(:number_sold)
      expect(error).to eq(null)
    end

  end

  # describe 'show action' do
  #   it 'sends data for one merchant' do
      
  #   end
  # end
end

  