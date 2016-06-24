class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :words, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  before_save :strip_whitespace
  

  validates :title, presence: true, length: { maximum: 55 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :subject, presence: true, length: { maximum: 55 }
  validates :difficulty, presence: true, numericality: { less_than_or_equal_to: 5 }

  def enrollment_for(student_user)
    return nil unless student_user
    enrollments.find_by(user: student_user)
  end

  private
    def strip_whitespace
      self.title = self.title.split.join(' ')
      self.description = self.description.split.join(' ')
    end
end
