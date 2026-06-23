class Decoration < ApplicationRecord
  has_many_attached :photos
  has_many :budgets
  belongs_to :event_type

  validates :name, presence: :true

  scope :search, ->(term) {
    return all if term.blank?

    sanitized_term = "%#{sanitize_sql_like(term)}%"
    where("name ILIKE ?", sanitized_term)
  }

  def self.find_by_event_type_id(event_type_id)
    where(event_type_id: event_type_id)
  end
end
