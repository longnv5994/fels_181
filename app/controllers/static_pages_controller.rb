class StaticPagesController < ApplicationController
  def home
    @category = Category.new if logged_in?
  end

  def help
  end
end
