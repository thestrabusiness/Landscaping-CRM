module ApplicationHelper  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.permit(:sort, :direction, :page).merge(:sort => column, :direction => direction, :page => nil)
  end
end
