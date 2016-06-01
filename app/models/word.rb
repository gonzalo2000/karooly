class Word < ActiveRecord::Base
  belongs_to :lesson

  validates :term, presence: true, length: { maximum: 55 }
  validates :reference, presence: true, length: { maximum: 55 }
end
