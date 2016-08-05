class WordDictation < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :term, to: :word 
  delegate :image, to: :word
  delegate :sound, to: :word

  attr_accessor :dictation_attempt

  before_update :dictations_update

  validate :dictation_matches_word, on: :update

  def dictation_matches_word
    if word.term != self.dictation_attempt.split.join(' ')
      errors.add(:term_given_by_student, "Terms don't match") 
      false
    else
      true
    end
  end

  def dictations_update
    if dictation_matches_word
      self.completed = true
    end
  end

  def next_dictation
    WordDictation.where(["sequence > ? AND enrollment_id = ?", sequence, enrollment_id]).order(:sequence).first
  end
end
