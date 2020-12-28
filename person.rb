class Person
  attr_reader :mother_name, :name, :gender, :spouse_name, :children_names

  def initialize(mother_name, name, gender)
    @name = name
    @gender = gender
    @mother_name = mother_name
    @children_names = []
    @spouse_name = nil
  end

  def add_spouse_info(name)
    @spouse_name = name
  end

  def add_children(name)
    @children_names.push(name)
  end
end
