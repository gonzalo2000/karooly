class Word < ActiveRecord::Base
  belongs_to :lesson
  has_many :word_expositions, dependent: :destroy
  before_save :strip_whitespace

  mount_uploader :image, ImageUploader
  mount_uploader :sound, SoundUploader

  validates :term, presence: true, length: { maximum: 55 }
  validates :reference, presence: true, length: { maximum: 55 }
  validates :image, presence: true
  validates :sound, presence: true

  def previous
    Word.where(["id < ? AND lesson_id = ?", id, lesson_id]).last
  end

  def next
    Word.where(["id > ? AND lesson_id = ?", id, lesson_id]).first
  end

  private
    def strip_whitespace
      self.term = self.term.split.join(' ')
      self.reference = self.reference.split.join(' ')
    end
end
