module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def description(page_description)
    content_for :description, page_description.to_s
  end

  def description_tag
    content_tag :meta, nil, name: 'description', content: content_for(:description) if content_for?(:description)
  end

  def keywords(page_keywords)
    content_for :keywords, page_keywords.to_s
  end

  def keywords_tag
    content_tag :meta, nil, name: 'keywords', content: content_for(:keywords) if content_for?(:keywords)
  end

  def tab_link(text, path, active:)
    content_tag :li, class: "#{'active' if active }" do
      link_to path do
        concat content_tag :span, text
      end
    end
  end
end
