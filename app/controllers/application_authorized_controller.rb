# frozen_string_literal: true

class ApplicationAuthorizedController < ApplicationController
  before_action :authorize_user!
end
