require "./relations/base"
Dir["./relations/*.rb"].each {|file| require file }

class RelationParse
  def self.perform(tree, person_name, relation_name)
    relation = Kernel.const_get(relation_name.delete('-'))
    relation.new(tree, person_name).find_names
  end
end
