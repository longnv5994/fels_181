class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :load_category, only: [:edit, :update, :destroy, :show]

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.per_page
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
    end
      redirect_to admin_categories_path
  end

  def create
    @category = Category.new category_params
      if @category.save
        flash[:success] = t "add_success"
      end
    redirect_to :back
  end

  def destroy
    if @category.verify_destroy_category
      flash[:danger] = t "category.can_not_delete"
    else
      @category.destroy
      flash[:success] = t "category.delete"
    end
    redirect_to admin_categories_path
  end

  def show
    respond_to do |format|
      format.html {render template: "admin/categories/show", layout: false}
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "category.blank"
      redirect_to root_url
    end
  end
end
