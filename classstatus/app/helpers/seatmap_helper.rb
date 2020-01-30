module SeatmapHelper
  def unseated
    total_seats = 30 # XXX: this should get passed in or something...

    html = "<div class='area unseated'>\n"
    @enrollments.each do |e|
      html += student_item(e)
    end
    (total_seats - @enrollments.length).times do
      html += empty_seat
    end
    html += "</div>\n"

    html.html_safe
  end

  def seating_chart_buttons
    "<div class='seating-chart-buttons'>
      <button type='button' class='button-save btn btn-primary' name='save-button'>
        Save</button>
      <button type='button' class='button-clear btn btn-secondary' name='clear-button'>
        Clear</button>
      <button type='button' class='button-random btn btn-secondary' name='random-button'>
        Rand</button>
    </div>".html_safe
  end

  def empty_seatmap(rows, cols, row_lengths)
    html = "<div class='seatmap'>\n"
    rows.times do |r|
      html += seatmap_row(r, cols, row_lengths[r])
    end
    html += "</div>\n"

    html.html_safe
  end

  def seatmap(rows, cols, row_lengths)
    html = "<div class='seatmap'>\n"
    rows.times do |r|
      html += seatmap_row(r, cols, row_lengths[r])
    end
    html += "</div>\n"

    html.html_safe
  end

  def seatmap_row(row, cols, len)
    html = "<div class='seatmap-row'>\n"
    len.times do |c|
      html += seat(row, c)
    end
    (cols - len).times do
      html += not_a_seat
    end
    html += "</div>\n"

    html.html_safe
  end

  def seat(r, c)
    html = "<div class='area seat' data-seat-id='#{r}#{c}'>\n"

    html += "</div>\n"
  end

  ###
  # Generate one student tile.
  # @type {Enrollment}
  #
  def student_item(e)
    html =  "<div class='student-item' data-student-id='#{e.student_id}'>\n"
    html += "<div class='student-content' data-student-id='#{e.student_id}'>\n"
    html += "#{e.student.display_name}\n"
    html += "</div>\n"
    html += "</div>\n"
  end

  def empty_seat
    html =  "<div class='student-item empty-seat'>\n"
    html += "<div class='student-content empty-seat'>\n"
    html += "&nbsp\n" # Force item to have some vertical height.
    html += "</div>\n"
    html += "</div>\n"
  end

  def not_a_seat
    html =  "<div class='not-a-seat'>\n"
    html += "</div>\n"
  end
end
