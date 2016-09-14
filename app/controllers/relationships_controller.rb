class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find params[:id]
    current_user.follow @user
    current_user.create_activity Activity.activity_types[:follow], @user.id
    respond_to do |format|
      msg = {class: "unfollow"}
      format.json {render json: msg}
    end
  end

  def destroy
    current_user.unfollow params[:id]
    current_user.create_activity Activity.activity_types[:unfollow], params[:id]
    respond_to do |format|
      msg = {class: "follow"}
      format.json {render json: msg}
    end
  end
end
