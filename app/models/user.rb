# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  include UserMenu
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_accesses

  accepts_nested_attributes_for :user_accesses, allow_destroy: true

  def permitions
    @permitions ||= user_accesses || {}
  end

  def total_access
    user_menu_items
  end
end
