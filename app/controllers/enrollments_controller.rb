class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :lesson_empty?, only: [:create]

  def create
    current_user.enrollments.create(lesson: current_lesson)
    redirect_to lesson_path(current_lesson)
  end

  private

  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end

  def lesson_empty?
    if current_lesson.words.empty?
      flash[:alert] = "You may not enroll in lessons without vocabulary."
      redirect_to lessons_path
    end
  end
end
