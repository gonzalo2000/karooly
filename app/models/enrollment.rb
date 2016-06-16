class Enrollment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  has_many :word_expositions

  after_create :create_the_associated_word_expositions

  def create_the_associated_word_expositions
    lesson.words.each { |word| word_expositions.create(word: word, completed: false) }
  end
end
