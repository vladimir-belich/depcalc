require 'spec_helper'

describe App do
  describe 'GET /' do
    it 'should return the calculator page' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'POST /' do
    it 'should return the page with the calculation' do
      post '/tabl', { start_date: '16-03-2020', months: 3, interest_rate: 13, start_sum: 30000.00, capitalization_method: 0 }
      expect(last_response).to be_ok
    end
  end
end
