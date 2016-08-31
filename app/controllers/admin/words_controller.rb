class Admin::WordsController < ApplicationController
  before_action :load_word, only: [:edit, :update]
  before_action :logged_in_user, :verify_admin

  def new
    @word = Word.new
    @word.word_answers.build
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def index
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:info] = t "word.create"
      redirect_to :back
    else
      flash[:danger] = t "word.not_create"
      render :new
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "word.update"
      redirect_to :word
    else
      flash[:danger] = t "word.not_update"
      render :edit
    end
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
        redirect_to :word
      end
    end
end
