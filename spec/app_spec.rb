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
    before( :each ) do
      clear_downloads
    end

    it 'should download the CSV file', js: true do
      visit '/'
      fill_in "sum", with: 30000.00
      fill_in "interest_rate", with: 13
      fill_in "start_date", with: '16-03-2020'
      fill_in "term", with: 3
      
      click_on 'Розрахувати'
      expect(page).to have_content 'Усього'

      page.find('#csv').click
      wait_for_download

      expect( File.read(download_path + '/output.csv') ).to include '#;date;days;sum;interest'
    end
  end 
end
