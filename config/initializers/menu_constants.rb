# frozen_string_literal: true

ActiveSupport::Notifications.subscribe 'routes_loaded.application' do
  path = Rails.application.routes.url_helpers

  cadastro_block_one = [
    {
      header: 'Básico',
      items: [
        {
          id: MENU_ACESSO[:usuarios],
          description: 'Usuários',
          action: path.users_admin_index_path,
          visible_menu: true
        }
      ]
    }
  ].freeze

  MENU_NAV = [
    {
      id: 'cadastro',
      description: 'Cadastros',
      icon: 'archive',
      sessions: [cadastro_block_one]
    }
  ].freeze
end
