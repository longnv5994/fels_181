class UsersController < ApplicationController
  def show
    @user = User.find_by_id params :id
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_id params :id
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end
end
