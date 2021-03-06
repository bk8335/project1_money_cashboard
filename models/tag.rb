require_relative('../db/sql_runner')

class Tag

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ('#{@name}') RETURNING *"
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = #{id}"
    run = SqlRunner.run(sql)
    result = Tag.new(run.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM tags"
    result = SqlRunner.run(sql)
    return result.map{|a_tag|Tag.new(a_tag)}
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = #{id}"
    return SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

end