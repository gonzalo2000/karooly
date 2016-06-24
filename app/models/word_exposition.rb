class WordExposition < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :reference, to: :word
  delegate :image, to: :word
  delegate :sound, to: :word

  attr_accessor :term_given_by_student

  before_update :custom_update

  validate :word_from_student_matches_word, on: :update

  def word_from_student_matches_word
    if word.term != self.term_given_by_student.split.join(' ')
      errors.add(:term_given_by_student, "Terms don't match") #this is not showing on errors 
      false
    else
      true
    end
  end

  def next_exposition
    WordExposition.where(["id > ? AND enrollment_id = ?", id, enrollment_id]).first
  end

  def custom_update
    if word_from_student_matches_word
      self.completed = true
    end
  end
end
