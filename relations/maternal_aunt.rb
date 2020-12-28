# Mother’s sisters
class MaternalAunt < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    self.person = traverse_up(person.name)
    process(siblings(FEMALE))
  end
end
