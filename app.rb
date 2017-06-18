require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, 'sqlite:///'+Dir.pwd+'/project.db')

class Todo
	include DataMapper::Resource

	property :id, 			Serial
	property :task, 		String
	property :done,			Boolean, :default => false
	property :impo, 		Boolean, :default => false
	property :urge, 		Boolean, :default => false
	
	# def initialize task
		
	# @task = task
	# 	@done = false
	# 	@impo = false
	# 	@urge = false
	# end
end

DataMapper.finalize # We are telling data mapper, that we are done, defining tables
DataMapper.auto_upgrade!
# tasks = []

# t1 = Todo.new "First"
# t2 = Todo.new "Second"
# t3 = Todo.new "Third"

# tasks << t1
# tasks << t2
# tasks << t3

get '/' do
	data = Hash.new
	data[:tasks] = Todo.all
	erb :index, locals: data
end

post '/add' do
  puts params
  task = params["task"]
  todo = Todo.new
  todo.task = task
  todo.done = false

  if params.has_key? "Imp" 
  	imp = params["Imp"]
  	todo.impo = true
  end

  if params.has_key? "Urg" 
  	urg = params["Urg"]
  	todo.urge = true
  end
  
  todo.save
  # tasks << todo
  puts params
  return redirect '/'
end

post '/del' do
	task_id = params["id"].to_i
	todo = Todo.get(task_id)
	todo.destroy

	# task = params["task"]
	# tasks.each do |todo|
	# 	if todo.task == task
	# 		tasks.delete(todo)
	# 	end
	# end
	return redirect '/'
end

post '/done' do
	task_id = params["id"].to_i
	todo = Todo.get(task_id)
	todo.done = !todo.done
	todo.save

	# task = params["task"]

	# tasks.each do |todo|
	# 	if todo.task == task
	# 		todo.done = !todo.done
	# 	end
	# end

	return redirect '/'
end