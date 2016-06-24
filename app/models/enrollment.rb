class Enrollment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  has_many :word_expositions, dependent: :destroy
  has_many :scrambled_words, dependent: :destroy

  # has_many :words, through: :scrambled_words
  # has_many :words, through: :word_expositions

  after_create :create_the_associated_word_expositions
  after_create :create_the_associated_scrambled_words

  def create_the_associated_word_expositions
    lesson.words.each do |word| 
      word_expositions.create!(word: word, completed: false) 
    end
  end

  def create_the_associated_scrambled_words
    count = lesson.words.count
    sequences = (0...count).to_a.shuffle
    lesson.words.each do |word| 
      scrambled_words.create!(word: word, completed: false, sequence: sequences.pop) 
    end
  end

  def first_scrambled_word
    scrambled_words.order(:sequence).first
  end
end
