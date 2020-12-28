class Daughter < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    return NONE if person.gender == MALE && person.spouse_name
    self.person = find_person(person.spouse_name) if person.gender == MALE
    result = person.children_names.map do |name|
      child = find_person(name)
      child.name if child.gender == FEMALE
    end
    process(result.compact)
  end
end
