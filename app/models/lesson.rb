class Lesson < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :subject, presence: true
  validates :difficulty, presence: true
end
