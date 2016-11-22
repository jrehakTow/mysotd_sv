module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  #def hideable(column, title = nil)
    #title ||= column.titleize
    #puts params[:retired]
    #retired = params[:retired]

    #retired = toggle(retired)
    #link_to title, {:retired => retired}
  #end

  #def toggle(arg)
    #arg = !arg
  #end
end
