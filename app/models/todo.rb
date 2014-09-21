require 'vienna/adapters/rest'
require 'vienna/eventable'

class Todo < Vienna::Model
  extend Vienna::Eventable

  adapter Vienna::RESTAdapter
  url 'http://192.168.178.40:3000/todos'

  attributes :id, :title, :completed

  alias completed? completed

  # All active (not completed) todos
  def self.active
    all.reject(&:completed)
  end

  # All completed todos
  def self.completed
    all.select(&:completed)
  end
end
