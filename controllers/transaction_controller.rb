require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/transaction.rb')
require_relative( '../models/merchant.rb')
require_relative( '../models/fund.rb')
require_relative( '../models/tag.rb')
require_relative( '../models/currency_formatter.rb')

get '/spending/day' do
  @total_by_day = Transaction.total_by_day
  erb(:"transactions/day_spend")
end

get '/spending' do
  @total = Transaction.total_all_transactions()
  @total_formatted = CurrencyFormatter.separate_comma(@total.round(0))
  @remain = Fund.first_balance()
  @remain_formatted = CurrencyFormatter.separate_comma(@remain.round(0))
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
  transaction = Transaction.new(params)
  transaction.save
  @fund = Fund.get_first
  @fund.spend(params['value'])

  if @fund.balance < 0
    redirect to("/winner")
  end

  redirect to("/transactions")
end

post '/transactions/:id/delete' do
  transaction = Transaction.find(params[:id])
  transaction.delete()

  @fund = Fund.get_first()
  @fund.refund(transaction.value)
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
  @fund = Fund.get_first
  @fund.refund(params['original_value'])
  @fund.spend(params['value'])
  redirect to("/transactions")
end