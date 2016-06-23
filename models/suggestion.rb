class Suggestion < ActiveRecord::Base
  belongs_to :event

  before_create :generate_uuid

  validates :title, :description, :speaker, :format, :track, presence: true
  validates :format, :track, exclusion: { in: %w(no-value), message: "is not valid" }

  default_scope -> { where('deleted = ?', false) }

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
