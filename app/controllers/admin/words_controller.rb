class Admin::WordsController < ApplicationController
  before_action :load_word, only: [:edit, :update, :destroy]
  before_action :logged_in_user, :verify_admin
  before_action :load_categories, except: [:destroy, :show]

  def new
    @word = Word.new
    Settings.build.repeat.times {@word.word_answers.build}
  end

  def edit
  end

  def index
    if params[:search].present?
      @words = Word.filter_category(params[:search]).paginate page: params[:page],
        per_page: Settings.per_page
    else
      @words = Word.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
    @answers = WordAnswer.find_answers @words.ids
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:info] = t "word.create"
      redirect_to admin_words_url
    else
      flash[:danger] = t "word.not_create"
      render :new
    end
  end

  def update
    if @word.verify_used_word
      flash[:danger] = t "word.can_not_delete"
    else
      if @word.update_attributes word_params
        flash[:success] = t "word.update"
      else
        flash[:danger] = t "word.not_update"
      end
    end
    redirect_to admin_words_url
  end

  def destroy
    if @word.verify_used_word
      flash[:danger] = t "word.can_not_delete"
    else
      if @word.destroy
        flash[:success] = t "word.word_delete"
      else
        flash[:danger] = t "word.not_delete"
      end
    end
    redirect_to admin_words_url
  end

  private
    def word_params
      params.require(:word).permit :category_id, :content, word_answers_attributes:
        [:id, :content, :is_correct, :_destroy]
    end

    def load_categories
      @categories = Category.all
    end

    def load_word
      @word = Word.find_by id: params[:id]
      if @word.nil?
        flash[:danger] = t "word.miss"
        redirect_to admin_words_url
      end
    end
end
