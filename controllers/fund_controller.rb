require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')
require_relative( '../models/fund.rb')

get '/winner' do
  # when you go here, 
  # check if remaining is less then 0
  # top up 300 million.
  Transaction.inheritance()

  erb(:"transactions/winner")
  # Transaction.inheritance
end