class WordExposition < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  attr_accessor :term_given_by_student
  validate :word_from_student_matches_word

  def word_from_student_matches_word
    return true if word.term == term_given_by_student
    errors.add(:term_given_by_student, "Terms don't match")
  end

  def next_word_exposition
    #logic
  end
end
