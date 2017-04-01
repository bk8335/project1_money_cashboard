require_relative('../db/sql_runner')

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ('#{@name}') RETURNING *"
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

    def self.all()
    sql = "SELECT * FROM merchants"
    result = SqlRunner.run(sql)
    return result.map{|merchant|Merchant.new(merchant)}
  end

  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = #{id}"
    return SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end
end