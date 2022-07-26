class AddAcesso < ActiveRecord::Migration[6.0]
  def change
    create_table 'acesso', force: :cascade do |t|
      t.integer :user_id,    null: false
      t.integer :menu_opcao, null: false
    end
  end
end
