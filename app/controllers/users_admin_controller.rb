# frozen_string_literal: true

class UsersAdminController < ApplicationAuthorizedController
  before_action :authenticate_user!
  before_action :set_collections, only: %i[edit update new]
  before_action :set_user, only: %i[edit update destroy]
  before_action :format_params, only: %i[update create]

  ACCESS_ID = MENU_ACESSO[:usuarios]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
               .page(params[:page])
               .per(30)
               .without_count

    @users = @users.order(:id) if @q.sorts.empty?
  end

  def edit; end

  def update
    User.transaction do
      @user.user_accesses.destroy_all unless access_params.empty?

      UserAccess.create_to_user(@user, access_params) if access_params.present?
      true
    end

    return redirect_to users_admin_index_path, notice: 'Usuário atualizado com sucesso!' if @user.update(user_params)

    render :edit, collection: set_collections
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if params[:user][:password] != params[:user][:password_confirmation]
      return redirect_to request.referer, alert: 'Senhas não conferem!'
    end

    if @user.save
      UserAccess.create_to_user(@user, access_params) if access_params.present?

      return redirect_to users_admin_index_path, notice: 'Usuário registrado com sucesso!'
    end

    render :new, collection: set_collections
  end

  def destroy
    return redirect_to users_admin_index_path, notice: 'Usuário registrado com sucesso!' if @user.destroy

    render :index
  end

  private

  def set_collections
    @accesses = MenuFilter.accesses(MENU_NAV)
  end

  def set_user
    @user = User.find params[:id]
  end

  def format_params
    params[:user][:admin] = params[:user][:admin] == 'true'
  end

  def user_params
    user_p = params.require(:user).permit(:email, :name, :admin)

    if params[:user][:password].present?
      pass_params = params.require(:user).permit(:password, :password_confirmation)
      user_p = user_p.merge(pass_params)
    end

    user_p
  end

  def access_params
    return [] unless params[:access].present?

    params[:access].map(&:to_i)
  end
end
