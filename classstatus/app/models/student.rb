class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :sections, through: :enrollments

  validates :given_name,  presence: true
  validates :family_name, presence: true

  def display_name
    "#{preferred_name ? preferred_name : given_name} #{family_name}"
  end

  def initials
    "#{preferred_name ? preferred_name[0] : given_name[0]}#{family_name[0]}"
  end

  def sortable_name
    "#{family_name}, #{preferred_name ? preferred_name : given_name}"
  end

  def section_list
    list = ""
    self.sections.each do |s|
      list += "#{s.block.name} "
    end
    list.strip
  end
end
