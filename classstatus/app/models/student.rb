class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  def name
    self.full_name
  end

  def full_name
    "#{self.preferred_or_given_name} #{self.family_name}"
  end

  def sortable_name
    "#{self.family_name}, #{self.preferred_or_given_name}"
  end

  def short_name
    "#{self.preferred_or_given_name} #{self.family_name[0]}."
  end

  def initials
    "#{self.preferred_or_given_name[0]}#{self.family_name[0]}"
  end

  def preferred_or_given_name
    self.preferred_name ? self.preferred_name : self.given_name
  end

  # Take the attributes in new and merge (update) them into old. Don't change
  # the values of guid and id (id should be unset and a guid mismatch would be
  # a fatal error. Return a copy of old with updates from new.
  #
  # TODO: figure out how to avoid updating the student record if nothing has
  # changed - maybe have a compare routine and make the update conditional.
  def merge_attributes(new)
    merge = Student.new(attributes).attributes
    new.attributes.each do |key, value|
      case key
      when 'guid'       ; puts 'guid: skipped'
      when 'id'         ; puts 'id: skipped'
      when 'created_at' ;
      when 'updated_at' ;
      else
        merge[key] = value if merge.key?(key)
      end
    end
    merge
  end
end
