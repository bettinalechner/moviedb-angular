require 'spec_helper'

describe ActorsController do
	render_views

  describe 'index' do
  	before do
  		Actor.create!({ first_name: 'Uma', last_name: 'Thurman', date_of_birth: '1970-04-29'})
  		Actor.create!({ first_name: 'Lucy', last_name: 'Liu', date_of_birth: '1968-12-02'})
  		Actor.create!({ first_name: 'John', last_name: 'Travolta', date_of_birth: '1954-02-18'})

  		xhr :get, :index, format: :json, keywords: keywords
  	end

  	subject(:results) { JSON.parse(response.body) }

  	def extract_name
  		->(object) { object['firstName'] + ' ' + object['lastName'] }
  	end

  	context 'when the search finds results' do
  		let(:keywords) { 'Uma' }

  		it 'should 200' do
  			expect(response.status).to eq(200)
  		end

  		it 'should return one result' do
  			expect(results.size).to eq(1)
  		end

  		it 'should include Uma Thurman' do
  			expect(results.map(&extract_name)).to include('Uma Thurman')
  		end

  		it 'should not include John Travolta' do
  			expect(results.map(&extract_name)).to_not include('John Travolta')
  		end
  	end

  	context 'when the search doesn\'t find results' do
  		let(:keywords) { 'foo' }

  		it 'should return no results' do
  			expect(results.size).to eq(0)
  		end
  	end
  end

  describe 'show' do
    before do
      xhr :get, :show, format: :json, id: actor_id
    end

    subject(:results) { JSON.parse(response.body) }

    context 'when the actor exists' do
      let(:actor) {
        Actor.create!({ first_name: 'Uma', last_name: 'Thurman', date_of_birth: '1970-04-29'})
      }
      let(:actor_id) { actor.id }

      it { expect(response.status).to eq(200) }
      it { expect(results['id']).to eq(actor.id) }
      it { expect(results['firstName']).to eq(actor.first_name) }
      it { expect(results['lastName']).to eq(actor.last_name) }
      it { expect(results['dateOfBirth']).to eq(actor.date_of_birth.strftime('%Y-%m-%d')) }
    end

    context 'when the actor doesn\'t exist' do
      let(:actor_id) { -999 }
      it { expect(response.status).to eq(404) }
    end
  end

  describe 'create' do
    before do
      xhr :post, :create, format: :json, actor: {
        first_name: 'Tom',
        last_name: 'Hanks',
        date_of_birth: '1956-07-09'
      }
    end

    it { expect(response.status).to eq(201) }
    it { expect(Actor.last.first_name).to eq('Tom') }
    it { expect(Actor.last.last_name).to eq('Hanks') }
    it { expect(Actor.last.date_of_birth.strftime('%Y-%m-%d')).to eq('1956-07-09') }
  end

  describe 'update' do
    let(:actor) {
      Actor.create!({ first_name: 'Uma', last_name: 'Thurman', date_of_birth: '1970-04-29'})
    }

    before do
      xhr :put, :update, format: :json, id: actor.id, actor: {
        first_name: 'Tom',
        last_name: 'Hardy',
        date_of_birth: '1977-09-15'
      }

      actor.reload
    end

    it { expect(response.status).to eq(204) }
    it { expect(Actor.last.first_name).to eq('Tom') }
    it { expect(Actor.last.last_name).to eq('Hardy') }
    it { expect(Actor.last.date_of_birth.strftime('%Y-%m-%d')).to eq('1977-09-15') }
  end

  describe 'destroy' do
    let(:actor_id) {
      Actor.create!({ first_name: 'Uma', last_name: 'Thurman', date_of_birth: '1970-04-29'})
    }

    before do
      xhr :delete, :destroy, format: :json, id: actor_id
    end

    it { expect(response.status).to eq(204) }
    it { expect(Actor.find_by_id(actor_id)).to be_nil }
  end
end
