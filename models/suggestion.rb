class Suggestion < ActiveRecord::Base
  belongs_to :event

  validates :title, :description, :speaker, :format, :track, presence: true

  def before_create(suggesion)
    suggestion.uuid = SecureRandom.uuid
  end
end
