class WordExpositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  #not currently showing
  def show
    @word = current_lesson.words.find(params[:id])
  end

  def update
    #succesful word_from_student_matches_word
     
    flash[:notice] = "Congratulations! You're on your way to mastering this lesson."
    redirect_to #next_word_exposition 
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end

  def require_enrollment_in_lesson
    if !(current_user.enrolled_in?(current_lesson))
      redirect_to lesson_path(current_lesson), alert: 'You need to enroll in order to view the activities!'
    end
  end
end
