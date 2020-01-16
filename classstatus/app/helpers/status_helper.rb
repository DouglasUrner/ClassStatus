module StatusHelper
  # Display links to the sections passed in s during year y.
  def block_selector(y, s)
    links = ""
    (1..8).each do |b|
      if (Section.find_by(semester: s, block: b) == nil) then next end
      if (b == params[:id].to_i)
        links += link_to b, status_path(b), class: "active"
      else
        links += link_to b, status_path(b)
      end
      links += " "
    end
    return links.html_safe
  end

  # assignment_tile(submission, text, progress, workflow)
  # s: submission object from LMS
  # t: text to display in the tile
  # p: progress towards completion
  # w: "workflow" state of the assignment (pending, open, taught, due, closed)
  #
  # TODO: make link - to detailed status or submission
  # TODO: define values for p and w and set up CSS
  # TODO: default display for t (maybe grading status/score)
  def assignment_tile(s, t, p, w)
    html =  "<div class='assignment-status-tile progress-#{p} state-#{w}'>\n"
    html += "  <p>#{t}</p>\n"
    html += "</div>"
    return html.html_safe
  end

end
