class WordExposition < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :reference, to: :word
  delegate :image, to: :word
  delegate :sound, to: :word

  attr_accessor :term_given_by_student
  validate :word_from_student_matches_word, on: :update

  def word_from_student_matches_word
    return true if word.term == term_given_by_student.split.join(' ')
    errors.add(:term_given_by_student, "Terms don't match") #this is not showing on errors
  end

  #this breaks for non-adjacent records and for the last record
  def next_exposition
    WordExposition.where(["id > ? AND enrollment_id = ?", id, enrollment_id]).first
  end

end
