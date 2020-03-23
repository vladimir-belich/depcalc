# frozen_string_literal: true

class DepCalculator
  attr_reader :date, :months, :interest_rate, :sum, :sum_capital, :capitalization_method, :count

  def self.call(args)
    new(args).call
  end

  def initialize(start_date:, months:, interest_rate:, start_sum:, capitalization_method:)
    @date = start_date
    @months = months
    @interest_rate = interest_rate
    @sum = start_sum
    @sum_capital = 0
    @capitalization_method = capitalization_method
    @count = 1
  end

  def call
    interest_calculation
  end

  private

  def interest_calculation
    result_arr = Array[{ count: nil, date: date, days: 0, sum: sum, interest_amount: 0 }]

    perform_calculation(result_arr)

    add_total(result_arr)
  end

  def perform_calculation(result_arr)
    interest_amount = 0

    months.times do
      days = month_days
      interest_amount = calc(days)

      capitalization(interest_amount) unless capitalization_method.zero?

      netx_month
      result_arr << { count: count - 1, date: date, days: days, sum: sum.round(2),
                      interest_amount: interest_amount.round(2) }
    end
  end

  def calc(days)
    days_in_year = Date.leap?(date.year) ? 366 : 365
    ((sum * interest_rate / 100 * days) / days_in_year)
  end

  def capitalization(interest_amount)
    @sum_capital += interest_amount if !capitalization?(capitalization_method) || (capitalization_method == 1)
    return unless capitalization?(capitalization_method)

    @sum += @sum_capital
    @sum_capital = capitalization_method > 1 ? interest_amount : 0
  end

  def month_days
    mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    mdays[2] = 29 if Date.leap?(date.year)
    mdays[date.month]
  end

  def netx_month
    @date = date.next_month
    @count += 1
  end

  def capitalization?(capitalization_method)
    return true if monthly_capitalization(capitalization_method)
    return true if quarterly_capitalization(capitalization_method)
    return true if annual_capitalization(capitalization_method)

    false
  end

  def monthly_capitalization(capitalization_method)
    capitalization_method == 1
  end

  def quarterly_capitalization(capitalization_method)
    capitalization_method == 2 && (count % 3).zero?
  end

  def annual_capitalization(capitalization_method)
    capitalization_method == 3 && (count % 12).zero?
  end

  def add_total(result_arr)
    result_arr << { count: nil,
                    date: nil,
                    days: result_arr.map.sum { |e| e[:days] },
                    sum: result_arr.last[:sum],
                    interest_amount: result_arr.map.sum { |e| e[:interest_amount] }.round(2) }
  end
end
