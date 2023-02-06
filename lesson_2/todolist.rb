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
    self
  end

  def select
    list = TodoList.new(title)
    counter = 0
    while counter < size
      list.add(@todos[counter]) if yield(@todos[counter])
      counter += 1
    end
    list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    each do |todo|
      todo.done! if todo.title == title
    end
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  private

  def valid_index?(index)
    index < size
  end
end
