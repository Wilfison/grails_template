# frozen_string_literal: true

class Permition
  def initialize(user, access_code)
    @user = user
    @access_code = access_code
  end

  def can?(action)
    case action
    when 'new' || 'create'
      user.can_create?(access_code)
    when 'update', 'edit'
      user.can_edit?(access_code)
    else
      user.can_destroy?(access_code)
    end
  end

  private

  attr_reader :user, :access_code
end
