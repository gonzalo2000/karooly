class Teacher::WordsController < ApplicationController
  def new
    @lesson = Lesson.find(params[:lesson_id])
    @word = Word.new
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @word = @lesson.words.create(word_params)
    redirect_to teacher_lesson_path(@lesson)
  end

  private
    def word_params
      params.require(:word).permit(:term, :reference)
    end
end
