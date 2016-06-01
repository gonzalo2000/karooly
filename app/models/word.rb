class Word < ActiveRecord::Base
  belongs_to :lesson

  mount_uploader :image, ImageUploader

  validates :term, presence: true, length: { maximum: 55 }
  validates :reference, presence: true, length: { maximum: 55 }
end
