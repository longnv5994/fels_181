class LessonsController < ApplicationController
  before_action :load_categories, only: :index

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @lesson = Lesson.new category_id: params[:lesson][:category_id],
      user_id: current_user.id
    if @lesson.save
      flash[:success] = t "lesson.create.success"
      redirect_to lessons_path
    else
      flash[:danger] =  t "lesson.create.create_fail"
      redirect_to lessons_path
    end
  end

  private
  def load_categories
    @categories = Category.all
  end
end
