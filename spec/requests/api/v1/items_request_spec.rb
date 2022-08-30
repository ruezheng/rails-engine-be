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

          expect(item).to_not have_key(:number_sold)
        end
      end
    end

    context 'sad path' do
      it "returns an empty array if no items exist" do
        get '/api/v1/items'

        items = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)
        expect(items).to eq([])
      end
    end
  end

  describe 'GET /api/v1/items/:id endpoint' do
    context 'happy path' do
      it 'gets one item and its attributes by id' do
        merchant_id = create(:merchant).id
        id = create(:item, merchant_id: merchant_id).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(response.status).to eq(200)

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

        expect(item).to_not have_key(:number_sold)
      end
    end

    context 'sad path' do
      it "returns a 404 status if the id is not valid" do
        get "/api/v1/merchants/1"

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST /api/v1/items endpoint' do
    context 'happy path' do
      it 'creates a single item with the correct attributes' do
        merchant_id = create(:merchant).id

        item_params = {
          name: 'Bad Coffee',
          description: "The best dark roast you'll ever taste",
          unit_price: 26.50,
          merchant_id: merchant_id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

        expect(response.status).to eq(201)

        new_item = Item.last

        expect(new_item.id).to be_an(Integer)
        expect(new_item.name).to eq('Bad Coffee')
        expect(new_item.description).to eq("The best dark roast you'll ever taste")
        expect(new_item.unit_price).to eq(26.5)
        expect(new_item.merchant_id).to eq(merchant_id)
      end
    end

    context 'sad path' do
      it "returns a 404 status if not all item_params are present" do
        merchant_id = create(:merchant).id

        item_params = {
          name: 'Bad Coffee',
          description: "The best dark roast you'll ever taste",
          merchant_id: merchant_id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

        expect(response.status).to eq(404)
      end

      it "returns a 404 status if the item_params are not complete with valid data types" do
        merchant_id = create(:merchant).id

        item_params = {
          name: 'Bad Coffee',
          description: "The best dark roast you'll ever taste",
          unit_price: "not available",
          merchant_id: merchant_id
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'PATCH /api/v1/items/:id endpoint' do
    context 'happy path' do
      it 'updates a single item with the given item_params' do
        merchant_id = create(:merchant).id

        item_params = {
          name: 'Bad Coffee',
          description: "The best dark roast you'll ever taste",
          unit_price: 26.50,
          merchant_id: merchant_id
        }

        item = Item.create!(item_params)

        new_item_params = {
          unit_price: 30.00
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: new_item_params)

        updated_item = Item.last

        expect(updated_item.id).to be_an(Integer)
        expect(updated_item.name).to eq('Bad Coffee')
        expect(updated_item.description).to eq("The best dark roast you'll ever taste")
        expect(updated_item.unit_price).to eq(30.00)
        expect(updated_item.merchant_id).to eq(merchant_id)
      end
    end

    describe 'DESTROY /api/v1/items/:id endpoint' do
      context 'happy path' do
        it 'deletes a single item record by id' do
          merchant_id = create(:merchant).id
          id = create(:item, merchant_id: merchant_id).id

          delete "/api/v1/items/#{id}"

          expect(response.status).to eq(204)
        end
      end

      context 'sad path' do
        it 'renders status 404 if item id is invalid' do
          merchant_id = create(:merchant).id
          id = create(:item, merchant_id: merchant_id).id + 1

          delete "/api/v1/items/#{id}"

          expect(response.status).to eq(404)
        end
      end
    end
  end
end
