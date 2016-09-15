class WordAnswersController < ApplicationController
  before_action :load_wordanswer, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update]
  def new
    @word_answer = WordAnswer.new
  end

  def show
  end

  def edit
  end

  def index
  end

  def create
    @word_answer = WordAnswer.new word_answer_params
    if @word_answer.save
      flash[:info] = t "word_answer.create"
      redirect_to :back
    else
      render :new
    end
  end

  def update
    if @word_answer.update_attributes word_answer_params
      flash[:success] = t "word_answer.update"
      redirect_to :word
    else
      render :edit
    end
  end

  private
    def word_answer_params
      params.require(:word),permit :category_id, :content
    end

    def load_word
      @word_answer = WordAnswer.find_by id: params[:id]
      if @word_answer.nil?
        flash[:danger] = t "word_answer.miss"
        redirect_to :word
      end
    end

    def admin_user
      redirect_to root_url unless current_user.is_admin?
    end
end
