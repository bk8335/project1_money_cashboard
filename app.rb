require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/transaction_controller')

get '/home' do
  @transactions = Transaction.all()
  @total = Total.new(0)
  erb(:home)
end




