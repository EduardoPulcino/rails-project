class Decoration < ApplicationRecord
  has_one_attached :photo
  has_many :budgets
  belongs_to :event_type

  def self.find_by_event_type_id(event_type_id)
    where(event_type_id: event_type_id)
  end
end
