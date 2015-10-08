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

  def main_menu_link(path, active_key, icon, text)
    # main_menu_key = try(:main_menu_key) || nil
    content_tag :li, class: "#{'active' if active_key == @main_menu_key }" do
      link_to path do
        concat content_tag :span, '', class: "fa #{icon}" if icon.present?
        concat content_tag :span, text
      end
    end
  end

  def form_field_error(field_name, form_record)
    if form_record.errors[field_name].any?
      content_tag :div, form_record.errors[field_name].join(', '), class: 'help-block'
    end
  end

  def form_field_group(field_name, form_record, &block)
    content_tag :div, capture(&block), class: "form-group #{'has-error' if form_record.errors[field_name].any?}"
  end
end
