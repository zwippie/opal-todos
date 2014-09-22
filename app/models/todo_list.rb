require 'vienna/adapters/rest'
require 'vienna/eventable'

class TodoList < Vienna::Model
  extend Vienna::eventable

  adapter Vienna::RESTAdapter
  url 'http://192.168.178.40:3000/todo_lists'

  attributes :id, :name, :todo_count
end