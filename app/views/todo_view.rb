class TodoView < Vienna::View
  template :todo

  on :dblclick, 'label' do
    @element.add_class 'editing'
    @input.focus
  end

  on :keypress, '.edit' do |e|
    finish_editing if e.which == 13
  end

  on :blur, '.edit' do
    finish_editing
  end

  on :click, '.destroy' do
    @todo.destroy
  end

  on :click, '.toggle' do
    @todo.update :completed => !@todo.completed
  end

  def initialize(todo)
    @todo = todo
    # @todo.on(:create) { |todo| puts "Added todo with id @todo.id"; @todo.id = todo.id; render }
    @todo.on(:update) { render }
    @todo.on(:destroy) { remove }
    @todo.on(:filter) { |filter| apply_filter filter }
  end

  def apply_filter(filter)
    element.toggle_class :hidden, hidden?(filter)
  end

  def hidden?(filter)
    completed = @todo.completed?

    !completed && filter == 'completed' or completed && filter == 'active'
  end

  def clear
    @todo.destroy
  end

  def finish_editing
    puts "Finished editing #{@todo.id}", @todo
    value = @input.value.strip
    @element.remove_class 'editing'
    value.empty? ? clear : @todo.update(:title => value)
  end

  def remove
    element.remove
  end

  def render
    super
    @input = element.find '.edit'
  end

  def tag_name
    :li
  end
end
