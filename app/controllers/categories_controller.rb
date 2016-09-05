class CategoriesController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
    end
      redirect_to categories_path
  end

  def create
    @category = Category.new category_params
      if @category.save
        flash[:success] = t "add_success"
      end
    redirect_to :back
  end

  def destroy
    @category.destroy
    redirect_to :back
  end

  def show
    @categories = Category.all
    @category = Category.new
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
