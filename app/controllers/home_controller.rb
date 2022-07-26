# frozen_string_literal: true

class HomeController < ApplicationAuthorizedController
  before_action :authenticate_user!

  def index; end
end
