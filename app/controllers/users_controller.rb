class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
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
      redirect_to @user
    else
      render :new
    end
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
