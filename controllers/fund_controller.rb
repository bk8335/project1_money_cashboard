require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')
require_relative( '../models/fund.rb')

get '/winner' do
  @fund = Fund.get_first
  if @fund.balance < 0
    Fund.reset()
  end

  erb(:"transactions/winner")
end