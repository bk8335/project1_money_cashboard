class Fund

  attr_accessor :balance

  def initialize(options)
    @id = options['id'].to_i
    @balance = options['balance'].to_i
  end

  def save 
    sql = "INSERT INTO funds (balance) VALUES (#{@balance}) RETURNING *"
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

  def self.reset
    sql = "UPDATE funds SET balance = 300000000"
    SqlRunner.run(sql)
  end

  # def balance
  #   sql = "SELECT balance FROM funds where id = #{@id}"
  #   result = SqlRunner.run(sql).first
  #   fund = Fund.new(result)
  #   return fund.balance
  # end

  def spend(amount)
    @balance = @balance - amount.to_i
    sql = "UPDATE funds SET balance = #{@balance} WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def refund(amount)
    @balance = @balance + amount.to_i
    sql = "UPDATE funds SET balance = #{@balance} WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.get_first()
    sql = "SELECT * FROM funds"
    result = SqlRunner.run(sql).first
    return Fund.new(result)
  end

  def self.delete_all
    sql = "DELETE FROM funds"
    SqlRunner.run(sql)
  end

  def self.first_balance
    fund = self.get_first()
    return fund.balance
  end

end