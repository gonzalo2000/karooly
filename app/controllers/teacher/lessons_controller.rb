class Teacher::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show, :edit, :update]

  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def create
    @lesson = current_user.lessons.create(lesson_params)
    if @lesson.valid?
      redirect_to teacher_lesson_path(@lesson)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    current_lesson.update_attributes(lesson_params)
    redirect_to teacher_lesson_path(current_lesson)
  end
  
  private
    def require_authorized_for_current_lesson
      if current_lesson.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end

    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :description, :subject, :difficulty)
    end
end
