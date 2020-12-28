require "./person"

class Tree
  attr_accessor :family_index

  MALE = 'male'.freeze
  FEMALE = 'female'.freeze
  PERSON_NOT_FOUND = 'PERSON_NOT_FOUND'.freeze
  CHILD_ADDITION_FAILED = 'CHILD_ADDITION_FAILED'.freeze
  CHILD_ADDITION_SUCCEEDED = 'CHILD_ADDITION_SUCCEEDED'.freeze

  def initialize(king_name, queen_name)
    @family_index = {}
    king = Person.new(nil, king_name, MALE)
    queen = Person.new(nil, queen_name, FEMALE)
    family_index[king_name.to_sym] = king
    family_index[queen_name.to_sym] = queen
    queen.add_spouse_info(king.name)
  end

  def find_person(name)
    family_index[name.to_sym]
  end

  def traverse_up(name)
    person = find_person(name)
    find_person(person.mother_name)
  end

  def add_child(mother_name, name, gender)
    if person_obj = find_person(mother_name)
      if person_obj.gender == FEMALE
        person_obj.add_children(name.to_sym)
        family_index[name.to_sym] = Person.new(mother_name, name, gender.downcase)
        CHILD_ADDITION_SUCCEEDED
      else
        CHILD_ADDITION_FAILED
      end
    else
      PERSON_NOT_FOUND
    end
  end

  def add_child_to_queen(name, gender, _)
    mother = find_person("Queen Anga")
    mother.add_children(name.to_sym)
    family_index[name.to_sym] = Person.new("Queen Anga", name, gender.downcase)
    CHILD_ADDITION_SUCCEEDED
  end
end
