module AttendanceRecordsHelper
def attendance_block(student, default = 'in_class')
    html  = "<div>\n"
    AttendanceRecord.primaries.keys.each do |p|
      html += "<input type='radio' name=\'ar_p-#{student.id}\' value=\'#{p}\' #{'checked' if p == default}>\n"
    end
    AttendanceRecord.secondaries.keys.each do |s|
      html += "<input type='radio' name=\'ar_s-#{student.id}\' value=\'#{s}\'>\n"
    end
    html += "</div>\n"
    html.html_safe
  end
end
