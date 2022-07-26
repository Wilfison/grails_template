# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  ACCESS_ID = nil

  def authorize_user!
    return false unless current_user

    authorized = can_access_this_resource?

    return redirect_to (request.referer || root_path), alert: 'Você não tem autorização!' unless authorized
  end

  def can_access_this_resource?
    return true unless self.class::ACCESS_ID

    authorize access_menu, :has_access?
  end

  def access_menu
    AccessMenu.new(self.class::ACCESS_ID)
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    notice = t "#{policy_name}.#{exception.query}", scope: 'pundit', default: :default

    redirect_to (request.referrer || root_path), alert: notice
  end
end
