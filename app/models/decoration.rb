class Decoration < ApplicationRecord
  has_one_attached :photo
  belongs_to :event_type
end
