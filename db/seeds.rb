require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require('pry')

Transaction.delete_all
Merchant.delete_all
Tag.delete_all

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

