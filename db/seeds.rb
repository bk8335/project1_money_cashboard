require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/total')
require('pry')

Transaction.delete_all
Merchant.delete_all
Tag.delete_all

total = Total.new(0)

merchant1 = Merchant.new('name' => 'Tesco')
merchant2 = Merchant.new('name' => 'Footlights')
merchant1.save
merchant2.save

tag1 = Tag.new('name' => 'food')
tag2 = Tag.new('name' => 'booze')
tag1.save
tag2.save

transaction1 = Transaction.new('merchant_id' => merchant1.id, 'tag_id' => tag1.id, 'value' => 8.65, 'description' => 'lots of junk food' )
transaction1.save

transaction2 = Transaction.new('merchant_id' => merchant2.id, 'tag_id' => tag2.id, 'value' => 22.47, 'description' => 'round of beers' )
transaction2.save

transaction3 = Transaction.new('merchant_id' => merchant2.id, 'tag_id' => tag2.id, 'value' => 14.89, 'description' => 'tequila' )
transaction3.save

transaction3.description = "jagerbombs"
transaction3.update

binding.pry
return nil

