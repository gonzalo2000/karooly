class WordsController < ApplicationController

  before_action :authenticate_user!, only: [:show]

  def show
  end

  private

    helper_method :current_word
    def current_word
      @current_word ||= Word.find(params[:id])
    end
end
