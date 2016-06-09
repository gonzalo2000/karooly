class User < ActiveRecord::Base
  has_many :lessons
  has_many :enrollments
  has_many :enrolled_lessons, through: :enrollments, source: :lesson
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def enrolled_in?(lesson)  
    enrolled_lessons.include?(lesson)
  end

end
