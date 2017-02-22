require_relative ('../db/sqlrunner.rb')

class Student
  attr_accessor :first_name, :second_name, :house_id, :age
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i
    @first_name = options['first_name']
    @second_name = options['second_name']
    @house_id = options['house_id']
    @age = options['age'].to_i
  end

  def full_name
    return "#{@first_name} #{@second_name}"
  end

  def self.delete_all
    sql = "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO students (first_name, second_name, house_id, age) VALUES ('#{@first_name}','#{@second_name}',#{@house_id},#{@age}) RETURNING id"
    student = SqlRunner.run(sql).first
    @id= student['id'].to_i
  end

def house()
puts "the student ID is #{@id}"
sql = "SELECT name FROM houses INNER JOIN students ON students.house_id = houses.id WHERE students.id = #{@id}"
house = SqlRunner.run(sql).first
puts house['name']



end


  def self.all
    sql = "SELECT * FROM students"
    return self.get_many(sql) 
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM students WHERE id = #{id_required}"
    student = SqlRunner.run(sql)
    result = Student.new(student.first)
  end


  def self.get_many(sql)
    students = SqlRunner.run(sql)
    result = students.map {|student| Student.new(student)}
    return result

  end


end
