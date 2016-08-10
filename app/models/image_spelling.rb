class ImageSpelling < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :image, to: :word

  attr_accessor :spelling_attempt

  before_update :spelling_update

  validate :spelling_matches_word, on: :update

  def spelling_matches_word
    if word.term != self.spelling_attempt.split.join(' ')
      errors.add(:term_given_by_student, "Terms don't match") 
      false
    else
      true
    end
  end

  def spelling_update
    if spelling_matches_word
      self.completed = true
    end
  end

  def next_spelling
    ImageSpelling.where(["sequence > ? AND enrollment_id = ?", sequence, enrollment_id]).order(:sequence).first
  end
end
