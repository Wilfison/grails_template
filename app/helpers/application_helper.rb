# frozen_string_literal: false

module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def hide_default_layout
    content_for(:hide_default_layout) { 'hide' }
  end

  def link_to_prev_page_index(scope, name, options)
    prev_page = path_to_prev_page(scope, options)
    return nil if prev_page.blank?

    options[:rel] ||= 'prev'

    link_to prev_page, options do
      "#{icon('fas', 'angle-double-left')} #{name}".html_safe
    end
  end

  def link_to_next_page_index(scope, name, options)
    next_page = path_to_next_page(scope, options)
    return nil if next_page.blank?

    options[:rel] ||= 'next'

    link_to next_page, options do
      "#{name} #{icon('fas', 'angle-double-right')}".html_safe
    end
  end
end
