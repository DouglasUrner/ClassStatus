module SectionsHelper
  def section_progress_picker
    items = ""
    # XXX: sorting on :block_id is fragile - use block.sort_order
    Section.order(:block_id).each do |s|
      items += "<li>#{link_to s.short_name, progress_section_path(s), class: 'dropdown-item'}</li>"
    end
    items.html_safe
  end
end
