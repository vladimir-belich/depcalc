require 'sinatra/base'
require 'byebug'

class App < Sinatra::Base
  get '/' do
    erb :calc
  end

  post '/tabl' do
    months = params[:months].to_i
    start_date = Date.parse params[:start_date]
    sum = params[:sum].to_f
    interest_rate = params[:interest_rate].to_f
    capitalization_method = params[:capitalization_method].to_i
  end  
end
