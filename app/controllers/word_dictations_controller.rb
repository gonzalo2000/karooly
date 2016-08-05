class WordDictationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def show
    @word = current_enrollment.word_dictations.find_by!(word_id: params[:id])
  end

  def update
    current_dictation
    @current_dictation.dictation_attempt = params[:word_dictation][:dictation_attempt]
    
    if @current_dictation.save  
      if next_dictated = @current_dictation.next_dictation
        flash[:notice] = "Congratulations!"
        redirect_to lesson_word_dictation_path(current_lesson, next_dictated.word)
      else
        flash[:notice] = "Dictation activity complete!"
        redirect_to lesson_path(current_lesson)
      end
    else
      flash[:alert] = "Incorrect... Try again!"
      redirect_to lesson_word_dictation_path(current_lesson, current_dictation.word)
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

  def word_dictations_params
    params.require(:word_dictation).permit(:completed)
  end

  helper_method :current_dictation
  def current_dictation
    @current_dictation ||= current_enrollment.word_dictations.find_by!(word_id: params[:id])
  end


end
