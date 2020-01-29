module SeatmapHelper
  def unseated(enrollments)
    html = "<div class='area unseated'>\n"
    enrollments.each do |e|
      html += student_item(e)
    end
    html += "</div>\n"

    html.html_safe
  end

  def seating_chart_buttons
    "<div class='seating-chart-buttons'>
      <button type='button' class='btn button-save' name='save-button'>
        Save</button>
      <button type='button' class='btn button-clear' name='clear-button'>
        Clear</button>
      <button type='button' class='btn button-random' name='random-button'>
        Random</button>
    </div>".html_safe
  end

  def empty_seatmap(rows, cols, row_lengths)
    html = "<div class='seatmap'>\n"
    rows.times do |r|
      html += seatmap_row(cols, row_lengths[r])
    end
    html += "</div>\n"

    html.html_safe
  end

  def seatmap(enrollments, rows, cols, row_lengths)
    html = "<div class='seatmap'>\n"
    rows.times do |r|
      html += seatmap_row(cols, row_lengths[r])
    end
    html += "</div>\n"

    html.html_safe
  end

  def seatmap_row(cols, len)
    html = "<div class='seatmap-row'>\n"
    len.times do |c|
      html += seat
    end
    (cols - len).times do
      html += not_a_seat
    end
    html += "</div>\n"

    html.html_safe
  end

  def seat
    html = "<div class='area seat'>\n"

    html += "</div>\n"
  end

  def student_item(enrollment)
    html =  "<div class='student-item'>\n"
    html += "<div class='student-content'>\n"
    html += "#{enrollment.student.display_name}\n"
    html += "</div>\n"
    html += "</div>\n"
  end

  def empty_seat
    html =  "<div class='student-item empty-seat'>\n"
    html += "<div class='student-content'>\n"
    html += "</div>\n"
    html += "</div>\n"
  end

  def not_a_seat
    html =  "<div class='not-a-seat'>\n"
    html += "</div>\n"
  end
end
