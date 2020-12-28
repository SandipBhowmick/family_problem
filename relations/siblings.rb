class Siblings < Base
  def find_names
    return PERSON_NOT_FOUND unless person
    process(siblings)
  end
end
