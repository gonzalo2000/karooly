class Enrollment < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  has_many :word_expositions, dependent: :destroy
  has_many :scrambled_words, dependent: :destroy
  has_many :word_dictations, dependent: :destroy
  has_many :image_spellings, dependent: :destroy

  after_create :create_the_associated_word_expositions
  after_create :create_the_associated_scrambled_words
  after_create :create_the_associated_word_dictations
  after_create :create_the_associated_image_spellings

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

  def create_the_associated_word_dictations
    count = lesson.words.count
    sequences = (0...count).to_a.shuffle
    lesson.words.each do |word| 
      word_dictations.create!(word: word, completed: false, sequence: sequences.pop) 
    end
  end

  def create_the_associated_image_spellings
    count = lesson.words.count
    sequences = (0...count).to_a.shuffle
    lesson.words.each do |word| 
      image_spellings.create!(word: word, completed: false, sequence: sequences.pop) 
    end
  end

  def first_scrambled_word
    scrambled_words.order(:sequence).first
  end

  def first_word_dictation
    word_dictations.order(:sequence).first
  end

  def first_image_spelling
    image_spellings.order(:sequence).first
  end
end
