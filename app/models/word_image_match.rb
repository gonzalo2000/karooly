class WordImageMatch < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :word

  delegate :image, to: :word

  attr_accessor :image_id_chosen_by_student

  def random_words
    other_words = Word.where("id != ? AND lesson_id = ?", id, word.lesson_id).order("RANDOM()").limit(2)
    ([word] + other_words).shuffle
  end
end

#create WordImageMatch on enrollment

