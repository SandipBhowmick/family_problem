# Spouse’s brothers, Husbands of siblings
class BrotherInLaw < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    brother_in_law = []
    brother_in_law = sibling_in_law(MALE).each do |sibling|
      men = find_person(sibling)
      men.spouse_name if men.spouse_name
    end.compact
    return NONE unless person.spouse_name || brother_in_law.any?
    return process(brother_in_law) if brother_in_law.any?
    self.person = find_person(person.spouse_name)
    process(siblings(MALE))
  end
end
