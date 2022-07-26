# frozen_string_literal: true

class ModelTemplateQueries
  attr_reader :q

  def initialize(params = {})
    @params = params
    @q = scope_query.ransack(params[:q])
  end

  def to_relation
    scope = q
            .result
            .page(params[:page])
            .per(30)
            .without_count

    scope = scope.order(:id) if q.sorts.empty?

    scope
  end

  private

  attr_reader :params

  def scope_query
    # return current_user.resources if current_user.present?

    ModelTemplate
  end
end
