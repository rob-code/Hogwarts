require_relative('../db/sqlrunner.rb')

class House
  attr_accessor :name, :logo_url
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @logo_url = options['logo_url']
  end

  def self.delete_all
    sql = "DELETE FROM houses"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO houses (name, logo_url) VALUES ('#{@name}', '#{@logo_url}') RETURNING id"
    house = SqlRunner.run(sql).first
    @id = house['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM houses"
    return self.get_many(sql) 
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM houses WHERE id = #{id_required}"
    house = SqlRunner.run(sql)
    result = House.new(house.first)
  end

end