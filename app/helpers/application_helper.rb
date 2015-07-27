module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(), extensions = {})
    markdown.render(text)
  end

  def title(title)
    content_for(:title) { title }
  end

  def page_title(page_title)
    content_for(:page_title) { page_title }
  end
  
  def page_class(page_class)
    content_for(:page_class) { page_class }
  end

  def back_link_url(back_link_url)
    content_for(:back_link_url) { back_link_url }
  end
end
