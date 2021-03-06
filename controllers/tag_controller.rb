require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/tag.rb')

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get '/tags/new' do
  @tags = Tag.all
  erb(:"tags/new")
end

post '/tags' do
  @tag = Tag.new(params)
  @tag.save
  erb(:"tags/confirmation_new")
end

post '/tags/:id/delete' do
  Tag.delete(params[:id])
  redirect to('/tags')
end