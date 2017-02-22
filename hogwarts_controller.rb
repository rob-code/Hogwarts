require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require('./models/student.rb')
require('./models/house.rb')

get '/students' do
@students = Student.all
erb(:index)
end

get '/students/new' do
@houses = House.all
erb(:new)
end

post '/students' do
puts params.inspect
@student = Student.new(params)
@student.save()
erb(:create)
end

get '/students/:id' do
  @student = Student.return_by_id(params[:id])
  erb(:show)
end



