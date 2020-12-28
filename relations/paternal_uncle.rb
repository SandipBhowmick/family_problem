# Father’s brothers
class PaternalUncle < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    self.person = traverse_up(person.name)
    return NONE unless person.spouse_name
    self.person = find_person(person.spouse_name)
    process(siblings(MALE))
  end
end
