module AttendanceRecordsHelper
def attendance_block(student, default = 'in_class')
    html  = "<div>\n"
    AttendanceRecord.states.keys.each do |s|
      html += "<input type='radio' name=\'ar-#{student.id}\' value=\'#{s}\' #{'checked' if s == default}>\n"
    end
    html += "</div>\n"
    html.html_safe
  end
end
