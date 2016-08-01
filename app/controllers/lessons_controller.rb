class LessonsController < ApplicationController
  def index
    @lessons = Lesson.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end

  helper_method :completed_expo
  def completed_expo
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_expositions = current_enrollment.word_expositions
      all_expositions.all? { |word_expo| word_expo.completed == true }
    end
  end

  helper_method :completed_unscramble
  def completed_unscramble
    lesson = Lesson.find(params[:id])
    if current_enrollment = lesson.enrollment_for(current_user)
      all_unscramble = current_enrollment.scrambled_words
      all_unscramble.all? { |scrambled| scrambled.completed == true }
    end
  end

  helper_method :enrolled_users
  def enrolled_users
    lesson = Lesson.find(params[:id])
    enrollments = lesson.enrollments
    enrolled_users = enrollments.map { |enrollment| enrollment.user }
  end
end
