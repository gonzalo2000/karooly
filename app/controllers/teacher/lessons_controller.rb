class Teacher::LessonsController < ApplicationController
  before_action :authenticate_user!

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = current_user.lessons.create(lesson_params)
    if @lesson.valid?
      redirect_to teacher_lesson_path(@lesson)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
  end
  
  private

  def lesson_params
    params.require(:lesson).permit(:title, :description, :subject, :difficulty)
  end
end
