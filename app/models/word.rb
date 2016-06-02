class Word < ActiveRecord::Base
  belongs_to :lesson

  mount_uploader :image, ImageUploader
  mount_uploader :sound, SoundUploader

  validates :term, presence: true, length: { maximum: 55 }
  validates :reference, presence: true, length: { maximum: 55 }
  validates :image, presence: true
  validates :sound, presence: true
end
