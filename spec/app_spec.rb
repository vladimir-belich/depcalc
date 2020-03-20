require 'spec_helper'
require 'date'

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

describe DepCalculator do
  describe '.call' do
    subject { described_class.call(start_date: start_date, months: months, interest_rate: interest_rate, start_sum: start_sum, capitalization_method: capitalization_method) }

    context 'without capitalization' do
      let(:start_date) { Date.parse('15-03-2020') }
      let(:months) { 1 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 0 }

      it 'returns the calculation of the deposit for 1 month' do
        
        is_expected.to eq([{date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {date: Date.parse('2020-04-15'), days: 31, sum: 30000.00, interest_amount: 331.23},
                           {date: nil, days: 31, sum: 30000.00, interest_amount: 331.23}])
      end
    end

    context 'with a monthly capitalization' do
      let(:start_date) { Date.parse('15-03-2020') }
      let(:months) { 2 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 1 }

      it 'returns the calculation of the deposit for 2 months with a monthly capitalization' do
        
        is_expected.to eq([{date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {date: Date.parse('2020-04-15'), days: 31, sum: 30331.23, interest_amount: 331.23},
                           {date: Date.parse('2020-05-15'), days: 30, sum: 30655.32, interest_amount: 324.09},
                           {date: nil, days: 61, sum: 30655.32, interest_amount: 655.32}])
      end
    end

    context 'with a quarterly capitalization' do
      let(:start_date) { Date.parse('15-03-2020') }
      let(:months) { 6 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 2 }

      it 'returns the calculation of the deposit for 6 months with a quarterly capitalization' do
        
        is_expected.to eq([{date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {date: Date.parse('2020-04-15'), days: 31, sum: 30000.00, interest_amount: 331.23},
                           {date: Date.parse('2020-05-15'), days: 30, sum: 30000.00, interest_amount: 320.55},
                           {date: Date.parse('2020-06-15'), days: 31, sum: 30651.78, interest_amount: 331.23},
                           {date: Date.parse('2020-07-15'), days: 30, sum: 30651.78, interest_amount: 327.51},
                           {date: Date.parse('2020-08-15'), days: 31, sum: 30651.78, interest_amount: 338.43},
                           {date: Date.parse('2020-09-15'), days: 31, sum: 31648.96, interest_amount: 338.43},
                           {date: nil, days: 184, sum: 31648.96, interest_amount: 1987.38}])
      end
    end
  end
end