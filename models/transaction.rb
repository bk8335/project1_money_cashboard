require_relative( '../db/sql_runner')


class Transaction

  attr_reader :id, :merchant_id, :tag_id
  attr_accessor :value, :description

  def initialize(options)
    @id           = options['id'].to_i
    @merchant_id  = options['merchant_id'].to_i
    @tag_id       = options['tag_id'].to_i
    @value        = options['value'].to_f
    @description  = options['description']
  end

  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, value, description) VALUES (#{@merchant_id}, #{@tag_id}, #{@value}, '#{@description}') RETURNING *"
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

  def update()
    sql = "UPDATE transactions SET
      merchant_id = #{@merchant_id},
      tag_id = #{@tag_id},
      value = #{@value}, 
      description = '#{@description}'
      WHERE id=#{id}"
    SqlRunner.run(sql)
  end

  def merchant()
    sql = "SELECT * FROM merchants WHERE id = #{@merchant_id}"
    result = SqlRunner.run(sql)
    return Merchant.new(result.first)
  end

  def tag()
    sql = "SELECT * FROM tags WHERE id = #{@tag_id}"
    result = SqlRunner.run(sql)
    return Tag.new(result.first)
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = #{id}"
    transaction = SqlRunner.run(sql)
    result = Transaction.new(transaction.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    result = SqlRunner.run(sql)
    return result.map {|transaction| Transaction.new(transaction) }
  end

  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.total_all_transactions
    transactions = self.all()
    total = 0
    transactions.each do |transaction|
      total += transaction.value
    end
    return total
  end

  # def self.total_by_tag
  #   sql = "SELECT * FROM tags WHERE id = #{@tag_id}"
  #   result = SqlRunner.run(sql)


  # end
end