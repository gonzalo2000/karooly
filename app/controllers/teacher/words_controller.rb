class Teacher::WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def new
    @word = Word.new
  end

  def edit
    @word = Word.find(params[:id])
  end

  def create
    @word = current_lesson.words.create(word_params)
    if @word.valid?
      current_lesson.reset_activities
      redirect_to teacher_lesson_path(current_lesson)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @word = Word.find(params[:id])

    if @word.update(word_params)
      current_lesson.reset_activities
      redirect_to teacher_lesson_path(current_lesson)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    redirect_to teacher_lesson_path(current_lesson)
  end

  private

    def require_authorized_for_current_lesson
      if current_lesson.user != current_user
        render text: 'Unauthorized', status: :unauthorized
      end
    end

    helper_method :current_lesson
    def current_lesson
      @current_lesson ||= Lesson.find(params[:lesson_id])
    end

    def word_params
      params.require(:word).permit(:term, :reference, :image, :sound)
    end
end
