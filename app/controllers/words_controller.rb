class WordsController < ApplicationController
  def index
    @categories = Category.all
  end

  def get_words
    filter_type = params[:rd][:learn] || Settings.word_filter.last
    if params["cate"] != ""
      @words = Word.send(filter_type, current_user.id).
        where_contains(params[:para][:txtkeyword]).
        where(category_id: params["cate"]).paginate page: params[:page],
          per_page: Settings.per_page
    else
      @words = Word.send(filter_type, current_user.id).
        where_contains(params[:para][:txtkeyword]).
        paginate page: params[:page], per_page: Settings.per_page
    end

    respond_to do |format|
      format.html {render template: "words/item_word", layout: false}
    end
  end
end
