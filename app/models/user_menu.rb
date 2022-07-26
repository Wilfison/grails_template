# frozen_string_literal: true

module UserMenu
  def user_menu_items
    user_items = []
    user_items = user_accesses.pluck(:menu_opcao).uniq if user_accesses.present?

    user_items
  end

  def menu_items_array
    items = []
    menu_navigation.each do |nav|
      nav[:sessions].each do |sessions|
        sessions.each do |session|
          session[:items].each do |item|
            items << { atalho_id: item[:id], path: item[:action], description: item[:subject] }
          end
        end
      end
    end

    items
  end

  def menu_navigation
    nav = []

    MENU_NAV.each do |menu_item|
      sessions = filtered_menu_sessions(user_menu_items, menu_item[:sessions])

      next unless sessions.any?

      filter_nav = {}.merge(menu_item)
      filter_nav[:sessions] = sessions

      nav << filter_nav
    end

    nav
  end

  def filtered_menu_sessions(user_items, menu_blocks)
    filter = []

    menu_blocks.each do |block|
      filter_block = []

      block.each do |block_session|
        filter_block_session = {}
        items = filtered_session_items(user_items, block_session[:items])

        next unless items.any?

        filter_block_session = filter_block_session.merge(block_session)
        filter_block_session[:items] = items

        filter_block << filter_block_session
      end

      filter << filter_block if filter_block.any?
    end

    filter
  end

  def filtered_session_items(user_items, session_items)
    session_items.select do |session_item|
      user_items.include? session_item[:id]
    end
  end
end
