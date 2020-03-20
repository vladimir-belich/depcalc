# frozen_string_literal: true

class DepCalculator
  attr_reader :start_date, :date, :months, :interest_rate, :start_sum, :capitalization_method

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @start_date = args[:start_date]
    @date = args[:start_date]
    @months = args[:months]
    @interest_rate = args[:interest_rate]
    @start_sum = args[:start_sum]
    @capitalization_method = args[:capitalization_method]
  end

  def call
    interest_calculation(start_sum)
  end

  def interest_calculation(sum)
    result_arr = Array[{ date: date, days: 0, sum: sum, interest_amount: 0 }]
    count = 1
    interest_amount = 0
    sum_capital = 0
    perform_calculation(count, interest_amount, sum, sum_capital, result_arr)
    add_total(result_arr)
  end

  private

  def perform_calculation(count, interest_amount, sum, sum_capital, result_arr)
    months.times do
      days = month_days
      interest_amount = calc(sum, days)

      sum_capital += interest_amount if !capitalization?(count, capitalization_method) || (capitalization_method == 1)

      if capitalization?(count, capitalization_method)
        sum += sum_capital
        sum_capital = capitalization_method > 1 ? interest_amount : 0
        count = 0
      end

      @date = date.next_month
      result_arr << { date: date, days: days, sum: sum.round(2), interest_amount: interest_amount.round(2) }

      count += 1
    end
  end

  def month_days
    mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    mdays[2] = 29 if Date.leap?(date.year)
    mdays[date.month]
  end

  def calc(sum, days)
    days_in_year = Date.leap?(date.year) ? 365 : 366
    ((sum * interest_rate / 100 * days) / days_in_year)
  end

  def capitalization?(count, capitalization_method)
    return true if monthly_capitalization(count, capitalization_method)
    return true if quarterly_capitalization(count, capitalization_method)
    return true if annual_capitalization(count, capitalization_method)
  end

  def monthly_capitalization(count, capitalization_method)
    capitalization_method == 1 && count == 1
  end

  def quarterly_capitalization(count, capitalization_method)
    capitalization_method == 2 && count == 3
  end

  def annual_capitalization(count, capitalization_method)
    capitalization_method == 3 && count == 12
  end

  def add_total(result_arr)
    result_arr << { date: nil,
                    days: result_arr.map.sum { |e| e[:days] },
                    sum: result_arr.last[:sum],
                    interest_amount: result_arr.map.sum { |e| e[:interest_amount] }.round(2) }
  end
end
