class Decoration < ApplicationRecord
  has_many_attached :photos
  has_many :budgets
  belongs_to :event_type

  validates :name, presence: :true

  def self.find_by_event_type_id(event_type_id)
    where(event_type_id: event_type_id)
  end
end
