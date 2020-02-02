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
        #{@enrollments.length}</button>
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
    html = "<div class='seatmap' style='width: 100%'>\n"
    rows.times do |r|
      html += seatmap_row(r, cols, row_lengths[r])
    end
    html += "</div>\n"

    html.html_safe
  end

  # def seatmap_variant(rows, cols, row_lengths)
  #   html = "<div class='seatmap name-only' style='width: 100%'>\n"
  #   rows.times do |r|
  #     html += seatmap_row(r, cols, row_lengths[r])
  #   end
  #   html += "</div>\n"
  #
  #   html.html_safe
  # end

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
  # Generate the container for one student tile.
  # @type {Enrollment}
  #
  def student_item(e)
    html  = "<div class='student-item' data-student-id='#{e.student_id}'>\n"
    html += "<div class='student-content' data-student-id='#{e.student_id}'>\n"
    html += student_tile(e)
    html += "</div>\n"
    html += "</div>\n"
  end

  # def student_item_varient(e)
  #   html  = "<div class='student-item' data-student-id='#{e.student_id}'>\n"
  #   html += "<div class='student-content' data-student-id='#{e.student_id}'>\n"
  #   html += student_tile_varient(e)
  #   html += "</div>\n"
  #   html += "</div>\n"
  # end

  ###
  # Generate a student tile
  #
  def student_tile(e)
    html  = "<div class='student-tile'>\n"

    html += "<div class='student-identity'>\n"
    html += "<p>#{e.student.display_name}</p>\n"
    html += "</div>\n"

    html += "<div class='student-progress'>\n"
    case action_name
    when 'attendance'
      # Nothing for now.
    when 'progress'
      html += annunciator_bar(e)
    when 'seating'
      html += annunciator_bar(e)
    end
    html += "</div>\n"

    html += "</div>\n"
  end

  # def student_tile_varient(e)
  #   html  = "<div class='student-tile'>\n"
  #
  #   html += "<div class='student-identity'>\n"
  #   html += "#{e.student.display_name}\n"
  #   html += "</div>\n"
  #
  #   html += "<div class='student-progress'>\n"
  #   # html += annunciator_bar(e)
  #   html += "</div>\n"
  #
  #   html += "</div>\n"
  # end

  def annunciator_bar(e)
    html  = "<div class='annunciator-bar'>\n"
    html += annunciator_basic(e)
    html += annunciator_spare
    html += annunciator_spare
    html += annunciator_attendance(e)
    html += "</div>\n"
  end

  def annunciator_basic(e)
    klass = "class='annunciator annunciator-cohort'"
    color = gpa_to_color(e)
    style = "style=\'border-color: #{color}\'"
    html  = "<div #{klass} #{style}>\n"
    html += "<div>#{e.student.cohort.to_s[3]}</div>"
    html += "</div>\n"
  end

  def annunciator_cohort(e)
    html  = "<div class='annunciator annunciator-cohort'>\n"
    html += "<div>#{e.student.cohort.to_s[3]}</div>"
    html += "</div>\n"
  end

  def annunciator_gpa(e)
    klass = "class='annunciator annunciator-gpa'"
    color = gpa_to_color(e)
    style = "style=\'background-color: #{color}\'"
    html  = "<div #{klass} #{style}>\n"
    html += "&nbsp;"
    html += "</div>\n"
  end

  # Display with shading for general sense with
  # stats in a tool tip.
  def annunciator_attendance(e)
    klass = "class='annunciator annunciator-attendance'"

    color = case e.student.overall_absence_rate(e.section_id)
    when       0.00 ; 'blue'
    when 0.00..0.02 ; 'green'
    when 0.02..0.06 ; 'yellow'
    when 0.06..0.10 ; 'orange'
    when 0.10..     ; 'red'
    when         -1 ; 'gray'     # No attendance records
    end
    style = "style=\'background-color: #{color}\'"

    tooltip = "data-toggle='tooltip' title=\'#{e.student.attendance_stats(e.section_id)}\'"

    html  = "<div #{klass} #{style} #{tooltip}>\n"
    html += "<div>#{e.student.recent_absences(e.section_id, 5)}</div>"
    html += "</div>\n"
  end

  def annunciator_spare
    html  = "<div class='annunciator annunciator-spare'>\n"
    html += "&nbsp;"
    html += "</div>\n"
  end

  def gpa_to_color(e)
    color = case e.student.gpa
    when 3.5..4.0 ; 'blue'
    when 2.5..3.5 ; 'green'
    when 1.5..2.5 ; 'yellow'
    when 1.0..1.5 ; 'orange'
    when 0.0..1.0 ; 'red'
    end
    if (e.student.gpa == 0 && e.student.cohort == 2023)
      color = 'purple'
    end
    color
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
