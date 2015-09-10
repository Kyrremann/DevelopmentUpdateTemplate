class Track < ActiveRecord::Base
  validates :title, presence: true
  validates :date, presence: true

  has_many :talks, dependent: :destroy
end
