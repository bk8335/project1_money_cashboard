require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/fund')
require('pry')

Transaction.delete_all
Merchant.delete_all
Tag.delete_all
Fund.delete_all

fund1 = Fund.new('balance' => 30_000_000)
fund1.save()

merchant1 = Merchant.new('name' => 'Balmoral')
merchant2 = Merchant.new('name' => 'Footlights')
merchant3 = Merchant.new('name' => 'Sunseeker')
merchant4 = Merchant.new('name' => 'Gulfstream')
merchant5 = Merchant.new('name' => 'Patek Philippe')
merchant1.save
merchant2.save
merchant3.save
merchant4.save
merchant5.save

tag1 = Tag.new('name' => 'Hotel')
tag2 = Tag.new('name' => 'Alcohol')
tag3 = Tag.new('name' => 'Yacht')
tag4 = Tag.new('name' => 'Watch')
tag5 = Tag.new('name' => 'Jet')

tag1.save
tag2.save
tag3.save
tag4.save
tag5.save

transaction2 = Transaction.new('merchant_id' => merchant2.id, 'tag_id' => tag2.id, 'value' => 200_000, 'description' => 'bar tab', 'transaction_date' => '2017-04-03')
transaction2.save

transaction3 = Transaction.new('merchant_id' => merchant2.id, 'tag_id' => tag2.id, 'value' => 500_000, 'description' => 'tequila', 'transaction_date' => '2017-04-03')
transaction3.save

transaction3.description = "jagerbombs"
transaction3.update

transaction1 = Transaction.new('merchant_id' => merchant1.id, 'tag_id' => tag1.id, 'value' => 500_000, 'description' => 'a month in the presidential suite', 'transaction_date' => '2017-04-04' )
transaction1.save

transaction4 = Transaction.new('merchant_id' => merchant3.id, 'tag_id' => tag3.id, 'value' => 6_000_000, 'description' => 'chartering a yacht for a month', 'transaction_date' => '2017-04-05')
transaction4.save



fund1.spend(Transaction.total_all_transactions)

return nil

