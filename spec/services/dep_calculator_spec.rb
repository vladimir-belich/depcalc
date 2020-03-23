require 'spec_helper'
require 'date'

describe DepCalculator do
  describe '.call' do
    subject { described_class.call(start_date: start_date, months: months, interest_rate: interest_rate, start_sum: start_sum, capitalization_method: capitalization_method) }

    context 'without capitalization' do
      let(:start_date) { Date.parse('15-03-2019') }
      let(:months) { 3 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 0 }

      it 'returns the calculation of the deposit for 3 month' do
        is_expected.to eq([{count: nil, date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {count: 1, date: Date.parse('2019-04-15'), days: 31, sum: 30000.00, interest_amount: 331.23},
                           {count: 2, date: Date.parse('2019-05-15'), days: 30, sum: 30000.00, interest_amount: 320.55},
                           {count: 3, date: Date.parse('2019-06-15'), days: 31, sum: 30000.00, interest_amount: 331.23},
                           {count: nil, date: nil, days: 92, sum: 30000.00, interest_amount: 983.01}])
      end
    end

    context 'with a monthly capitalization' do
      let(:start_date) { Date.parse('15-03-2019') }
      let(:months) { 3 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 1 }

      it 'returns the calculation of the deposit for 3 months with a monthly capitalization' do
        is_expected.to eq([{count: nil, date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {count: 1, date: Date.parse('2019-04-15'), days: 31, sum: 30331.23, interest_amount: 331.23},
                           {count: 2, date: Date.parse('2019-05-15'), days: 30, sum: 30655.32, interest_amount: 324.09},
                           {count: 3, date: Date.parse('2019-06-15'), days: 31, sum: 30993.79, interest_amount: 338.47},
                           {count: nil, date: nil, days: 92, sum: 30993.79, interest_amount: 993.79}])
      end
    end

    context 'with a quarterly capitalization' do
      let(:start_date) { Date.parse('15-03-2019') }
      let(:months) { 6 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 2 }

      it 'returns the calculation of the deposit for 6 months with a quarterly capitalization' do
        is_expected.to eq([{count: nil, date: start_date, days: 0, sum: start_sum, interest_amount: 0},
                           {count: 1, date: Date.parse('2019-04-15'), days: 31, sum: 30000.00, interest_amount: 331.23},
                           {count: 2, date: Date.parse('2019-05-15'), days: 30, sum: 30000.00, interest_amount: 320.55},
                           {count: 3, date: Date.parse('2019-06-15'), days: 31, sum: 30651.78, interest_amount: 331.23},
                           {count: 4, date: Date.parse('2019-07-15'), days: 30, sum: 30651.78, interest_amount: 327.51},
                           {count: 5, date: Date.parse('2019-08-15'), days: 31, sum: 30651.78, interest_amount: 338.43},
                           {count: 6, date: Date.parse('2019-09-15'), days: 31, sum: 31648.96, interest_amount: 338.43},
                           {count: nil, date: nil, days: 184, sum: 31648.96, interest_amount: 1987.38}])
      end
    end

    context 'with a annual capitalization' do
      let(:start_date) { Date.parse('01-01-2019') }
      let(:months) { 12 }
      let(:interest_rate) { 13 }
      let(:start_sum) { 30000.00 }
      let(:capitalization_method) { 3 }

      it 'returns the calculation of the deposit for 12 months with a annual capitalization' do
        is_expected.to include({count: nil, date: nil, days: 365, sum: 33568.77, interest_amount: 3899.99})
      end
    end
  end
end
