class Lesson < ActiveRecord::Base
  belongs_to :user
  has_many :words

  validates :title, presence: true, length: { maximum: 55 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :subject, presence: true, length: { maximum: 55 }
  validates :difficulty, presence: true, numericality: { less_than_or_equal_to: 5 }
end
