class ScrambledWord < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :image, to: :word

  attr_accessor :unscrambled_attempt

  before_update :my_custom_update

  validate :unscrambled_matches_word, on: :update

  def unscrambled_matches_word
    if word.term != self.unscrambled_attempt.split.join(' ')
      errors.add(:term_given_by_student, "Terms don't match") #this is not showing on errors 
    end
  end

  def my_custom_update
    if unscrambled_matches_word
      self.completed = true
    end
  end
end
