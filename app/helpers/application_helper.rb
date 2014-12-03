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
end
