class ScrambledWordsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def show
    @word = current_enrollment.scrambled_words.find_by!(word_id: params[:id])
  end

  def update
    #implement
    #will need a way to redirect to next upon success
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

  def scrambled_word_params
    params.require(:scrambled_word).permit(:completed)
  end

  helper_method :current_scrambled_word
  def current_scrambled_word
    @current_scrambled_word ||= current_enrollment.scrambled_words.find_by!(word_id: params[:id])
  end

  helper_method :scrambled_word_array
  def scrambled_word_array
    array = current_scrambled_word.term.chars.shuffle
    array.map! {|character| character == " " ? "_" : character }
  end
end
