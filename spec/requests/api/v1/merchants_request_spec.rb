require 'rails_helper'

Rspec.describe "Merchants API" do
  describe 'index action' do
    context 'happy path' do
      it 'all merchants returned are the same in the db' do
        create_list(:merchant, 3)
        
        get '/api/v1/merchants'
        
        expect(response.status).to eq(200)      
        expect(merchant).to have_key(:data) 
        
        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants.count).to eq(3)
        
        merchants.each do |merchant|
          expect(merchant).to have_key(:id) 
          expect(merchant[:id]).to be_an(Integer) 

          expect(merchant).to have_key(:name) 
          expect(merchant[:name]).to be_a(String) 
        end
      end
    end

  #   context 'sad path' do
  #     expect(response).to_not have_key(:number_sold) 
  #     expect(error).to eq(null)
  #   end
  # end  

  # describe 'show action' do
  #   it 'sends data for one merchant' do
      
  #   end
  # end
end

  