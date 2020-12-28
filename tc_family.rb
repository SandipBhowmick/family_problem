require "test/unit"
require "./tree"
require "./relation_parse"

class TestSimpleNumber < Test::Unit::TestCase
  GET_RELATIONSHIP = 'get_relationship'.freeze
  ADD_CHILD = 'add_child'.freeze
  ADD_CHILD_TO_QUEEN = 'add_child_to_queen'.freeze
  ADD_SPOUSE_INFO = 'add_spouse_info'.freeze

  def setup
    @tree = Tree.new('King Shan', 'Queen Anga')
    text = File.open("input1.rb").read
    text.each_line do |line|
      if line
        values = line.split(" ")
        method_name = values.shift.downcase
        arg_one, arg_two, arg_three = values
        case method_name
         when ADD_CHILD_TO_QUEEN, ADD_CHILD
           @tree.send(method_name, arg_one, arg_two, arg_three)
         when GET_RELATIONSHIP
           RelationParse.perform(@tree, arg_one, arg_two)
         when ADD_SPOUSE_INFO
            person = @tree.find_person(arg_one)
            person.add_spouse_info(arg_two)
         end
      end
    end
  end

  def test_add_child
    out, err = @tree.send(ADD_CHILD,"Satya", "Ketu", "Male")
    assert_match %r{CHILD_ADDITION_SUCCEEDED}, out
    out, err = @tree.send(ADD_CHILD,"Aras", "Ketu", "Male")
    assert_match %r{CHILD_ADDITION_FAILED}, out
    out, err = @tree.send(ADD_CHILD,"Pjali", "Srutak", "Male")
    assert_match %r{PERSON_NOT_FOUND}, out
  end

  def test_get_relationship
    out, err = RelationParse.perform(@tree,"Kriya", "Paternal-Uncle")
    assert_match %r{Asva}, out
    out, err = RelationParse.perform(@tree,"Satvy", "Brother-In-Law")
    assert_match %r{Vyas}, out
    out, err = RelationParse.perform(@tree,"Chit", "Siblings")
    assert_match %r{Ish Vich Aras Satya}, out
    out, err = RelationParse.perform(@tree,"Vasa", "Brother-In-Law")
    assert_match %r{NONE}, out
  end
end
