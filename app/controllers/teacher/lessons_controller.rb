class Teacher::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show, :edit, :update]

  def show
    lesson
  end

  def new
    @lesson = Lesson.new
  end

  def edit
    lesson
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
    if lesson.update(lesson_params)
      redirect_to teacher_lesson_path(lesson)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    lesson.destroy
    flash[:notice] = "Lesson destroyed."
    redirect_to dashboard_path
  end
  
  private
    def require_authorized_for_current_lesson
      if lesson.user != current_user
        render text: "Unauthorized", status: :unauthorized
      end
    end

    def lesson
      @lesson ||= Lesson.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :description, :subject, :difficulty)
    end
end
