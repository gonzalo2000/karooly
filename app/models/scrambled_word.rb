class ScrambledWord < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :image, to: :word

  attr_accessor :unscrambled_attempt
  validate :unscrambled_matches_word, on: :update

  def unscrambled_matches_word
    return true if word.term == unscrambled_attempt.split.join(' ')
    #errors.add(:term_given_by_student, "Terms don't match") #this is not showing on errors 
  end
end
