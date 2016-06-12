class LessonsController < ApplicationController
  def index
    @lessons = Lesson.order('created_at DESC').paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @lesson = Lesson.find(params[:id])
  end
end
