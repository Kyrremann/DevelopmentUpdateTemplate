class Track < ActiveRecord::Base
  has_many :talks, dependent: :destroy
end
