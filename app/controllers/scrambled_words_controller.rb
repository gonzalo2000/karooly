class ScrambledWordsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_in_lesson

  def index
    current_enrollment.next_incomplete_scrambled_word
  end

  def show
    @word = current_enrollment.scrambled_words.find_by!(word_id: params[:id])
  end

  #need to implement show next scrambled word upon succesful submission
  def update
    current_scrambled_word
    @current_scrambled_word.unscrambled_attempt = params[:scrambled_word][:unscrambled_attempt]
    
    if @current_scrambled_word.save  
      if next_scrambled = @current_scrambled_word.next_scramble
        flash[:notice] = "Congratulations!"
        redirect_to lesson_scrambled_word_path(current_lesson, next_scrambled.word)
      else
        flash[:notice] = "Scrambled activity complete!"
        redirect_to lesson_path(current_lesson)
      end
    else
      flash[:alert] = "Incorrect... Try again!"
      redirect_to lesson_scrambled_word_path(current_lesson, current_scrambled_word.word)
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
