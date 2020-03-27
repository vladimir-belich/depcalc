require 'spec_helper'

describe App do
  describe 'GET /' do
    it 'should return the calculator page' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'GET #table' do
    it 'should return the page with the calculation' do
      get '/table', { start_date: '16-03-2020', months: 3, interest_rate: 13, start_sum: 30000.00, capitalization_method: 0 }
      expect(last_response).to be_ok
    end
  end

  describe 'Download CSV' do
    it 'should return a CSV file with the calculation' do
      get '/file', { start_date: '16-03-2020', months: 3, interest_rate: 13, start_sum: 30000.00, capitalization_method: 0 }
      
      filename = last_request.env['rack.session']['session_id'].to_s[0..8] + '.csv'

      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'Application/octet-stream'
      expect(last_response.headers['Content-Disposition']).to include(filename)
    end
  end 
end
