class WordExpositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def show
    @word = current_enrollment.word_expositions.find_by!(word_id: params[:id])
  end

  def update
    current_word_exposition
    @current_word_exposition.completed = true
    @current_word_exposition.term_given_by_student = params[:word_exposition][:term_given_by_student]
    if @current_word_exposition.save
      
      if next_word = @current_word_exposition.next_exposition
        flash[:notice] = "Congratulations!"
        redirect_to lesson_word_exposition_path(current_lesson, next_word)
      else
        flash[:notice] = "Congratulations! Review complete."
        redirect_to lesson_path(current_lesson)
      end 
    else
      flash[:alert] = "Enter the word exactly as shown!"
      redirect_to lesson_word_exposition_path(current_lesson, current_word_exposition)
    end
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

  def word_exposition_params
    params.require(:word_exposition).permit(:completed)
  end

  helper_method :current_word_exposition
  def current_word_exposition
    @current_word_exposition ||= current_enrollment.word_expositions.find_by!(word_id: params[:id])
  end
end
