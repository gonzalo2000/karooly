class ImageSpellingsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def show
    @word = current_enrollment.image_spellings.find_by!(word_id: params[:id])
  end

  def update
    current_image_spelling
    @current_image_spelling.spelling_attempt = params[:image_spelling][:spelling_attempt]
    
    if @current_image_spelling.save  
      if next_spell = @current_image_spelling.next_spelling
        flash[:notice] = "Correct!"
        redirect_to lesson_image_spelling_path(current_lesson, next_spell.word)
      else
        current_enrollment.update_and_check_completed(:image_spelling_completed)
        flash[:notice] = "Spelling activity complete!"
        redirect_to lesson_path(current_lesson)
      end
    else
      flash[:alert] = "Incorrect... Try again!"
      redirect_to lesson_image_spelling_path(current_lesson, current_image_spelling.word)
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

  def image_spellings_params
    params.require(:image_spelling).permit(:completed)
  end

  helper_method :current_image_spelling
  def current_image_spelling
    @current_image_spelling ||= current_enrollment.image_spellings.find_by!(word_id: params[:id])
  end
end
