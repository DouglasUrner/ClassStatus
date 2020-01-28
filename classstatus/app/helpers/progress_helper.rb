module ProgressHelper
  def progress_section_picker
    items = ""
    # XXX: sorting on :block_id is fragile - use block.sort_order
    Section.order(:block_id).each do |s|
      items += "<li>#{link_to s.short_name, progress_path(s), class: 'dropdown-item'}</li>"
    end
    items.html_safe
  end

  def progress_tiles(enrollments)
    rows = 4
    cols = 8
    row_lengths = [ 8, 8, 8, 6 ]

    indent = 4

    html = "#{tab(indent)}<div class='seatmap'>\n" ; indent += 1
    rows.times do |r|
      html += "#{tab(indent)}<div class='seatmap-row'>\n" ; indent += 1
      row_lengths[r].times do |c|
        index = r * cols + c
        if (index < enrollments.length)
          html += "#{tab(indent)}<div class='area seat'>\n" ; indent += 1
            html += "#{tab(indent)}<div class='student-item'>\n" ; indent += 1
              html += "#{tab(indent)}<div class='student-content'>\n" ; indent += 1
                html += "#{tab(indent)}#{r}.#{c}<br>\n"
                html += "#{tab(indent)}#{enrollments[index].student.display_name}\n"
              html += "#{tab(indent -= 1)}</div>\n"
            html += "#{tab(indent -= 1)}</div>\n"
        else
          html += "#{tab(indent)}<div class='area seat empty-seat'>\n" ; indent += 1
            html += "#{tab(indent)}#{r}.#{c}<br>\n"
        end
        html += "#{tab(indent -= 1)}</div>\n"
      end
      (cols - row_lengths[r]).times do |c|
        html += "#{tab(indent)}<div class='area seat not-a-seat'>\n" ; indent += 1
        html += "#{tab(indent -= 1)}</div>\n"
      end
      html += "#{tab(indent -= 1)}</div>\n"
    end
    html += "#{tab(indent -= 1)}</div>\n"
    html.html_safe
  end

  def progress_tilesX(enrollments)
    rows = 4
    cols = 8
    row_lengths = [ 8, 8, 8, 6 ]
    @indent = 0

    html = "#{tab(@indent)}<div class='seatmap'>\n" ; @indent += 1

    divs = 0
    for i in 0..(enrollments.length - 1) do
      if (i % cols == 0)
        # Start of row.
        html += "#{tab(@indent)}<div 'seatmap-row'>\n"
        @indent += 1
        divs += 1
      end

      html += "#{tab(@indent)}<div class='area seat'>\n" ; divs += 1 ; @indent += 1
      #html += "#{tab(2)}<div class='student-item'>\n"
      #html += "#{tab(3)}<div class='student-content'>\n"
      html += "#{tab(@indent)}#{enrollments[i].student.display_name}\n"
      # Done with content, drop indent.
      #@indent -= 1
      #html += "#{tab(3)}</div>\n#{tab(2)}</div>\n#{tab(1)}</div>\n"
      html += close_divs(1) ; divs -= 1

      if (i % cols == (cols - 1) || i == (enrollments.length - 1))
        # End of row.
        @indent -= 1
        html += "#{tab(@indent)}</div 'seatmap-row'>\n"
        divs -= 1
      end

    end

    html += "</div>"

    html.html_safe

  end

  def tab(n)
    tabs = ''
    n.times do
      tabs += '  '
    end
    tabs
  end

  def close_divs(n)
    divs = ''
    n.times do
      divs += "#{tab(@indent)}</div>\n"
      @indent -= 1
    end
    divs.html_safe
  end

end
