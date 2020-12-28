require 'forwardable'
require 'byebug'

class Base
  extend Forwardable

  attr_accessor :person
  attr_reader :tree

  def_delegators :tree, :find_person, :traverse_up

  MALE = 'male'.freeze
  FEMALE = 'female'.freeze
  PERSON_NOT_FOUND = 'PERSON_NOT_FOUND'.freeze
  NONE = 'NONE'.freeze

  def initialize(tree, person_name)
    @tree = tree
    @person = find_person(person_name)
  end

  def siblings(type = nil)
    traverse_up(person.name).children_names.map do |name|
      child = find_person(name)
      child.name if person.name != child.name && child.spouse_name.nil? && (type.nil?  || child.gender == type)
    end.compact
  end

  def sibling_in_law(type = nil)
    traverse_up(person.name).children_names.map do |name|
      child = find_person(name)
      child.name if person.name != child.name && child.spouse_name && (type.nil?  || child.gender == type)
    end.compact
  end

  def process(result)
    result.any? ? result.join(' ') : NONE
  end
end
