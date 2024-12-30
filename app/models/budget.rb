class Budget < ApplicationRecord
  belongs_to :event_type
  belongs_to :user
  belongs_to :decoration

  validates :event_date, :guest_count, :start_time, :event_type, presence: true
  
  validates :guest_count, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 1, 
    less_than_or_equal_to: 180,
    message: "Must be a number between 1 and 180" 
  }

  validate :event_date_is_in_the_future

  private

  def event_date_is_in_the_future
    if event_date.present? && event_date <= Time.zone.today
      errors.add(:event_date, "deve ser uma data no futuro")
    end
  end
end
