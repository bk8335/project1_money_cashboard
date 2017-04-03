require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')
require_relative( '../models/merchant.rb')
require_relative( '../models/tag.rb')

get '/spending' do
  @total = Transaction.total_all_transactions()
  erb(:"transactions/home")
end

get '/spending/tag' do
  @tag_spending = Transaction.total_by_tag()
  erb(:"transactions/tag_spend")
end

get '/transactions' do
  @merchants = Merchant.all()
  @tags = Tag.all()
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
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.update()
  redirect to("/transactions")
end