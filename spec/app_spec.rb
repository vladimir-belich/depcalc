require 'spec_helper'

describe App do
  describe 'GET /' do
    it 'should return the calculator page' do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
