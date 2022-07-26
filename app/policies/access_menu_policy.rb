class AccessMenuPolicy
  attr_reader :user, :access_menu

  def initialize(user, access_menu)
    @user = user
    @access_menu = access_menu
  end

  def has_access?
    return true if @user.admin?

    @user.total_access.include? access_menu.id
  end
end
