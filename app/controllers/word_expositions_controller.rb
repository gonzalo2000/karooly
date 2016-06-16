class WordExpositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def show
    @word = current_enrollment.word_expositions.find_by!(word_id: params[:id])
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

  helper_method :current_enrollment
  def current_enrollment
    @current_enrollment ||= Enrollment.find_by!(lesson_id: params[:lesson_id], user_id: current_user.id)
  end

  def require_enrollment_in_lesson
    if !(current_user.enrolled_in?(current_lesson))
      redirect_to lesson_path(current_lesson), alert: 'You need to enroll in order to view the activities!'
    end
  end
end
