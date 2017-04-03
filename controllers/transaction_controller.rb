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
  @total = Transaction.total_all_transactions()

  @tag_spending = Transaction.total_by_tag()
  #creating a list because:
    # the changes in the tag_spending array of hashes were not storing
    # so instead we had to create a new array of hashes (called list), and store that in the erb file
  @list = []

  for tag in @tag_spending
     find_tag = Tag.find(tag['tag_id'])
     tag['name'] = find_tag.name
     @list.push(tag)
  end

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