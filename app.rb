require 'sinatra'

class Todo
	attr_accessor :task, :done, :impo, :urge
	def initialize task
		@task = task
		@done = false
		@impo = false
		@urge = false
	end
end

tasks = []

# t1 = Todo.new "First"
# t2 = Todo.new "Second"
# t3 = Todo.new "Third"

# tasks << t1
# tasks << t2
# tasks << t3

get '/' do
	data = Hash.new
	data[:tasks] = tasks
	erb :index, locals: data
end

post '/add' do
  puts params
  task = params["task"]
  todo = Todo.new task
  
  if params.has_key? "Imp" 
  	imp = params["Imp"]
  	todo.impo = true
  end

  if params.has_key? "Urg" 
  	urg = params["Urg"]
  	todo.urge = true
  end
  
  tasks << todo
  puts params
  return redirect '/'
end

post '/del' do
	task = params["task"]
	tasks.each do |todo|
		if todo.task == task
			tasks.delete(todo)
		end
	end
	return redirect '/'
end

post '/done' do
	task = params["task"]

	tasks.each do |todo|
		if todo.task == task
			todo.done = !todo.done
		end
	end

	return redirect '/'
end