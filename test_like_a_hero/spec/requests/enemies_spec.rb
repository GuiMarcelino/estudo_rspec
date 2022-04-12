require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    context 'when the enemy exists' do
      it 'returns status code 200' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes
        expect(response).to have_http_status(200)
      end

      it 'returns status code 204' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect(response).to have_http_status(204)
      end
    end

    context "when enemy exist" do
      it 'updates the record' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes
        expect(enemy.reload).to have_attributes(enemy_attributes) # reload pega o objeto atualizado ja com os parâmetros corretos
      end

      it 'returns the enemy update' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: enemy_attributes

        json_response = JSON.parse(response.body)
        expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at')) # com o except pois da problema com os campos
      end

      it 'destroy the record' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect{ enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exist' do
      it 'returns status code 404' do
        put '/enemies/0', params: attributes_for(:enemy)
        expect(response).to have_http_status(404)
      end

      it 'returns status code 404' do
        delete '/enemies/0', params: attributes_for(:enemy)
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        delete '/enemies/0'
        expect(response.body).to match(/Couldn't find Enemy/)
      end

      it 'returns a not found message' do
        put '/enemies/0', params: attributes_for(:enemy)
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end
end

