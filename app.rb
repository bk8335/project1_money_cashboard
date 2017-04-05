require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/transaction_controller')
require_relative('controllers/fund_controller')


get '/welcome' do
  erb(:welcome)
end

get '/' do
  redirect to("/welcome")
end


