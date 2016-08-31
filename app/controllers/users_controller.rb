class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]
  before_action :verify_admin, only: :destroy

  def new
    @user = User.new
  end

  def show
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "create"
      redirect_to login_path
    else
      render :new
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t "user_delete"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end

    def load_user
      @user = User.find_by id: params[:id]
      if @user.nil?
        flash[:danger] = t "miss_user"
        redirect_to root_url
      end
    end
end
