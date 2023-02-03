class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    if todo.class == Todo
      @todos << todo
    else
      puts 'Can only add Todo objects'
      raise TypeError
    end
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    raise IndexError unless valid_index?(index)

    @todos[index]
  end

  def mark_done_at(index)
    raise IndexError unless valid_index?(index)

    @todos[index].done!
  end

  def mark_undone_at(index)
    raise IndexError unless valid_index?(index)

    @todos[index].undone!
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    raise IndexError unless valid_index?(index)

    @todos.delete_at(index)
  end

  def to_s
    puts "---- Today's Todos ----"
    @todos.each do |todo|
      puts todo
    end
  end

  def each
    counter = 0
    while counter < size
      yield(@todos[counter])
      counter += 1
    end
  end

  def select
    results = []
    counter = 0
    while counter < size
      results << @todos[counter] if yield(@todos[counter])
      counter += 1
    end
    results
  end

  private

  def valid_index?(index)
    index < size
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect