class WordsController < ApplicationController
  def index
    @categories = Category.all
  end

  def get_words
    if params["cate"] != ""
      @words = Word.where_contains(params[:para][:txtkeyword]).
        where(category_id: params["cate"]).paginate page: params[:page],
          per_page: Settings.per_page
    else
      @words = Word.where_contains(params[:para][:txtkeyword]).
        paginate page: params[:page], per_page: Settings.per_page
    end

    respond_to do |format|
      format.html {render template: "words/itemword", layout: false}
    end
  end
end
