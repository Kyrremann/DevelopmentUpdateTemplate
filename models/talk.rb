class Talk < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :track
end
