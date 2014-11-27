module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(), extensions = {})
    markdown.render(text)
  end
end
