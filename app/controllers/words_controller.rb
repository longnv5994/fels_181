class WordsController < ApplicationController
  before_action :load_word, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update]
  def new
    @word = Word.new
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
      render :new
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "word.update"
      redirect_to :word
    else
      render :edit
    end
  end

  private
    def word_params
      params.require(:word),permit :category_id, :content
    end

    def load_word
      @word = Word.find_by id: params[:id]
      if @word.nil?
        flash[:danger] = t "word.miss"
        redirect_to :word
      end
    end

    def admin_user
      redirect_to root_url unless current_user.is_admin?
    end
end
