module ApplicationHelper

  def to_dos
    ToDo.all
  end

  def sortable(args)
    column = args.fetch(:column)
    title = args.fetch(:title) { column.titleize }
    controller = args[:controller]
    direction = (column == params[:sort] &&
      params[:direction] == "asc") ? "desc" : "asc"
    if controller
      link_to title, controller: controller, sort: column, direction: direction
    else
      link_to title, sort: column, direction: direction
    end
  end

  def sort_image(column)
     if params[:sort] && params[:direction]
      direction = params[:direction] == 'asc' ? 'down' : 'up'
      content_tag(:i, nil, class: "icon-chevron-#{direction}") unless params[:sort] != column
     elsif column == 'title'
      content_tag(:i, nil, class: 'icon-chevron-down')
     end
  end
end
