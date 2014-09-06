class StandardsRenderer < WillPaginate::ActionView::LinkRenderer
  def prepare(collection, options, template)
    @tab = options.delete :tab
    @link_path = options.delete :link_path
    @search = options.delete :search
    super
  end

protected
  def link(page, text, attributes = {})
    if @search
      "<a href='#{@link_path}?page=#{text}&search=#{@search}##{@tab}'>#{page}</a>"
    else
      "<a href='#{@link_path}?page=#{text}##{@tab}'>#{page}</a>"
    end.html_safe
  end
end
