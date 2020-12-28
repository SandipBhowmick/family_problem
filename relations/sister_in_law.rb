# Spouse’s sisters,Wives of siblings
class SisterInLaw < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    sister_in_law = []
    unless person.spouse_name
      sister_in_law = sibling_in_law(FEMALE).each do |sibling|
        women = find_person(sibling)
        women.spouse_name if women.spouse_name
      end.compact
    end
    return NONE unless person.spouse_name || sister_in_law.any?
    return process(sister_in_law) if sister_in_law.any?
    self.person = find_person(person.spouse_name)
    process(siblings(FEMALE))
  end
end
