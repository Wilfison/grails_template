# frozen_string_literal: true

class ModelTemplatesController < ApplicationAuthorizedController
  before_action :authenticate_user!
  before_action :find_resource, except: %i[index new create]

  ACCESS_ID = MENU_ACESSO[:resources]

  def index
    query = ModelTemplateQueries.new(params)

    @resources = query.to_relation
    @q = query.q
  end

  def new
    @resource = ModelTemplate.new
  end

  def edit; end

  def update
    if @resource.update(resource_item_params)
      flash[:notice] = 'Atualizado com sucesso!'
      return redirect_to resources_path
    end

    render :edit
  end

  def create
    @resource = ModelTemplate.new(resource_item_params)

    if @resource.save
      flash[:notice] = 'Criado com sucesso!'
      return redirect_to edit_resource_path(@resource)
    end

    render :new
  end

  def destroy
    if @resource.destroy
      flash[:notice] = 'Removido com sucesso!'
      return redirect_to resources_path
    end

    render :edit
  end

  private

  def find_resource
    @resource = ModelTemplate.find(params[:id])
  end

  def resource_item_params
    params.require(:resource).permit(
      :resource_params
    )
  end
end
