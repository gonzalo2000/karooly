class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user_lessons = current_user.lessons.order('created_at ASC')
    @user_enrolled_lessons = current_user.enrolled_lessons.order('created_at ASC')
  end
end
