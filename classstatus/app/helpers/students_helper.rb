module StudentsHelper

  # Format a student's name using the preferred name if available.
  def format_name(s)
    "#{s.preferred_name ? s.preferred_name : s.given_name} #{s.family_name}"
  end

  # Format a comma separated list of a student's sections.
  def student_sections(s)
    first = true
    sections = ""
    Enrollment.where(student_id: s).each do |e|
      if (first)
        sections = e.section.name
        first = false
      else
        sections += (", " + e.section.name)
      end
    end
    sections
  end

end
