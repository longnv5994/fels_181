class Admin::WordsController < ApplicationController
  before_action :load_word, only: [:edit, :update]
  before_action :logged_in_user, :verify_admin

  def new
    @word = Word.new
    @word.word_answers.build
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def index
    @categories = Category.all
    if params[:search]
      @words = Word.filter_category(params[:search]).paginate page: params[:page],
        per_page: Settings.per_page
    else
      @words = Word.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.per_page
    end
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
    if @word.update_attributes word_params
      flash[:success] = t "word.update"
      redirect_to admin_words_url
    else
      flash[:danger] = t "word.not_update"
      render :edit
    end
  end

  def destroy
    Word.find_by(id: params[:id]).destroy
    flash[:success] = t "word.word_delete"
    redirect_to admin_words_url
  end

  private
    def word_params
      params.require(:word).permit :category_id, :content, word_answers_attributes:
        [:id, :content, :is_correct]
    end

    def load_word
      @word = Word.find_by id: params[:id]
      if @word.nil?
        flash[:danger] = t "word.miss"
        redirect_to admin_words_url
      end
    end
end
