require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('./models/merchant.rb')
require_relative('./models/tag.rb')
require_relative('./models/transaction.rb')

get '/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  Merchant.new(params).save
  erb(:"merchants/confirmation_new")
end

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get '/tags/new' do
  erb(:"tags/new")
end

post '/tags' do
  Tag.new(params).save
  erb(:"tags/confirmation_new")
end

get '/transactions' do
  @transactions = Transaction.all()
  erb(:"transactions/index")
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do
  Transaction.new(params).save
  redirect to("/transactions")
end

post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end