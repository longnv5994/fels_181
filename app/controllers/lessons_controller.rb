class LessonsController < ApplicationController
  before_action :load_categories, only: :index
  before_action :load_lesson, :correct_user_lesson, only: [:edit, :update, :show]
  before_action :verify_completed_lesson, only: [:edit, :update]
  before_action :verify_uncompleted_lesson, only: :show

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @lesson = Lesson.new category_id: params[:lesson][:category_id],
      user_id: current_user.id
    if @lesson.save
      current_user.create_activity Activity.activity_types[:create_lesson],
        current_user.id
      flash[:success] = t "lesson.create.success"
    else
      flash[:danger] =  t "lesson.create.create_fail"
    end
    redirect_to lessons_path
  end

  def edit
  end

  def show
  end

  def update
    completed_lesson_params = lesson_params
    if params[:commit].eql? t("lesson.submit_btn")
      completed_lesson_params[:is_complete] = true
      @lesson.update_attributes completed_lesson_params
      current_user.create_activity Activity.activity_types[:finished],
        current_user.id
      redirect_to @lesson
    else
      completed_lesson_params[:is_complete] = false
      @lesson.update_attributes completed_lesson_params

    current_user.create_activity Activity.activity_types[:learn_lesson],
        current_user.id
      flash[:warning] = t "lesson.save_success"
      redirect_to lessons_path
    end
  end

  private
  def load_categories
    @categories = Category.all
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

  def correct_user_lesson
    unless current_user.current_user? @lesson.user
      flash[:danger] =  t "lesson.correct_user_lesson"
      redirect_to root_url
    end
  end

  def lesson_params
    params.require(:lesson).permit :is_complete,
      results_attributes: [:id, :word_answer_id]
  end

  def verify_completed_lesson
    if @lesson.is_complete?
      flash[:danger] = t "lesson.already_submit"
      flash[:info] = t "lesson.verify_completed_lesson"
      redirect_to lesson_path @lesson
    end
  end

  def verify_uncompleted_lesson
    unless @lesson.is_complete?
      flash[:danger] = t "lesson.verify_uncompleted_lesson"
      redirect_to edit_lessons_path @lesson
    end
  end
end
