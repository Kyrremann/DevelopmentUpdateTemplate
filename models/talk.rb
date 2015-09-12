class Talk < ActiveRecord::Base
  belongs_to :event
  has_many :comments, dependent: :destroy
end
