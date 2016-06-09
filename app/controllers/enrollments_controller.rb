class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.enrollments.create(lesson: current_lesson)
    redirect_to lesson_path(current_lesson)
  end

  private

  def current_lesson
    @current_lesson ||= Lesson.find(params[:lesson_id])
  end
end
