class Enrollment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  has_many :word_expositions, dependent: :destroy
  has_many :scrambled_words, dependent: :destroy

  has_many :words, through: :scrambled_words

  after_create :create_the_associated_word_expositions
  after_create :create_the_associated_scrambled_words

  def create_the_associated_word_expositions
    lesson.words.each do |word| 
      word_expositions.create!(word: word, completed: false) 
    end
  end

  def create_the_associated_scrambled_words
    lesson.words.each do |word| 
      scrambled_words.create!(word: word, completed: false) 
    end
  end
end
