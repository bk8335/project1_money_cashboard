require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/merchant.rb')

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

post '/merchant/:id/delete' do
  Merchant.delete(params[:id])
  redirect to("/merchants")
end