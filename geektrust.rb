#!/usr/bin/env ruby
require "./tree"
require "./relation_parse"
require "byebug"

GET_RELATIONSHIP = 'get_relationship'.freeze
ADD_CHILD = 'add_child'.freeze
ADD_CHILD_TO_QUEEN = 'add_child_to_queen'.freeze
ADD_SPOUSE_INFO = 'add_spouse_info'.freeze

puts 'The King Shan family tree'
puts 'Adding King Shan childrens ..........'

def method_parse(line)
  values = line.split(' ')
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

def main
  File.readlines("input1.rb").each_with_index do |line, indx|
    if indx.zero?
      values = line.split(' ')
      values.shift
      arg_one, arg_two = values.each_slice(2).to_a
      @tree = Tree.new(arg_one.join(' '), arg_two.join(' '))
    else
      puts method_parse(line) if line
    end
  end
  puts '[loading successful]'
  puts '********** Start operation on your input file **************'
  input_file = ARGV[0] # command line input analyser
  if (input_file != nil and input_file.strip != '')
    text = File.open(input_file).read
    text.each_line do |line|
      puts method_parse(line) if line
    end
  else
    puts 'Input file path error'
    exit
  end
end

main
