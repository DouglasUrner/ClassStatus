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

end
