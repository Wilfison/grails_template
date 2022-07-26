# frozen_string_literal: true

class UserAccess < ApplicationRecord
  self.table_name = 'acesso'

  def self.create_to_user(user, permitions)
    permitions += [1] # home

    values = permitions.map { |permition| "('#{user.id}', #{permition})" }.join(', ')

    ActiveRecord::Base.connection.execute("INSERT INTO acesso (user_id, menu_opcao) VALUES #{values}")
  end
end
