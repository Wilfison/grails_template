# frozen_string_literal: true

user = User.find_or_initialize_by(email: 'root@user.com')
user.name = 'Root'
user.password = '123456'
user.admin = true
user.save

UserAccess.create_to_user(user, MENU_ACESSO.values) if user.save
