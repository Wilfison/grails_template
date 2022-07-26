# frozen_string_literal: true

class MenuFilter
  def self.accesses(menu)
    menu.map do |submenu|
      {
        description: submenu[:description],
        items: get_menu_items(submenu[:sessions]).flatten
      }
    end
  end

  def self.get_menu_items(sessions)
    sessions.map do |session|
      get_block_items(session.map { |blocks| blocks })
    end
  end

  def self.get_block_items(blocks)
    blocks.map { |block| { block[:header] => block[:items] } }
  end
end
