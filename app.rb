# frozen_string_literal: true

require 'sinatra/base'
require_relative 'services/dep_calculator'
require 'csv'

class App < Sinatra::Base
  enable :sessions

  get '/' do
    erb :calc
  end

  get '/filename' do
    filename
  end

  get '/file' do
    months = params[:months].to_i
    start_date = Date.parse params[:start_date]
    sum = params[:sum].to_f
    interest_rate = params[:interest_rate].to_f
    capitalization_method = params[:capitalization_method].to_i

    csv = CSV.open('./tmp/' + filename, 'w', col_sep: ';')
    csv << %i[# date days sum interest]
    DepCalculator.call(start_date: start_date, months: months, interest_rate: interest_rate,
                       start_sum: sum, capitalization_method: capitalization_method).each do |row|
      csv << row.values
    end
    csv.close

    send_file './tmp/' + filename, filename: filename, type: 'Application/octet-stream'
  end

  get '/table' do
    months = params[:months].to_i
    start_date = Date.parse params[:start_date]
    sum = params[:sum].to_f
    interest_rate = params[:interest_rate].to_f
    capitalization_method = params[:capitalization_method].to_i

    erb :tabl, layout: false, locals: { months: months,
                                        date: start_date,
                                        sum: sum,
                                        interest_rate: interest_rate,
                                        capitalization_method: capitalization_method }
  end

  private

  def filename
    session[:session_id].to_s[0..8] + '.csv'
  end
end
