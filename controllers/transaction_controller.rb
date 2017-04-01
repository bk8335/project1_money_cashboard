require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')

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

#show
get '/transactions/:id' do
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/show")
end

#update
get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.update
  redirect to("/transactions")
end