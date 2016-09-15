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

  def activities_completed?
    expositions_completed && unscrambled_completed && dictation_completed && image_spelling_completed
  end

  def mark_completed
    puts "mark completed"
    update(:completed => true)
  end


  def check_completed
    mark_completed if activities_completed?
  end

  def update_and_check_completed(activity)
    update(activity => true)
    puts activity
    check_completed
  end

  def self.check_all_completed
    all.each do |e|
      if e.word_expositions.all? { |word_expo| word_expo.completed == true }
        e.update_and_check_completed(:expositions_completed)
      end

      if e.scrambled_words.all? { |scrambled| scrambled.completed == true }
        e.update_and_check_completed(:unscrambled_completed)
      end

      if e.word_dictations.all? { |dictation| dictation.completed == true }
        e.update_and_check_completed(:dictation_completed)
      end

      if e.image_spellings.all? { |spelling| spelling.completed == true }
        e.update_and_check_completed(:image_spelling_completed)
      end
    end
  end


end
