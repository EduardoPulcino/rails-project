class Budget < ApplicationRecord
  belongs_to :event_type
  belongs_to :user
  belongs_to :decoration, optional: true

  scope :search, -> (term) {
    return all if term.blank?

    sanitized_term = "%#{sanitize_sql_like(term)}%"

    joins(:user, :event_type)
    .where("users.name ILIKE ? OR event_types.name ILIKE ?", sanitized_term, sanitized_term)
  }

  scope :period, -> (period) {
    case period
    when 'this_week'
      where(event_date: Date.current.beginning_of_week..Date.current.end_of_week)
      .order(event_date: :asc)
    when 'this_month'
      where(event_date: Date.current.beginning_of_month..Date.current.end_of_month)
      .order(event_date: :asc)
    when 'next_30_days'
      where(event_date: Date.current..30.days.from_now)
      .order(event_date: :asc)
    when 'this_year'
      where(event_date: Date.current.beginning_of_year..Date.current.end_of_year)
      .order(event_date: :asc)
    when 'next'
      where("event_date > ?", Date.current)
      .order(event_date: :asc)
    end
  }

  before_save :calculate_profit

  validates :event_date, :guest_count, :start_time, :event_type, presence: true
  
  validates :guest_count, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 1, 
    less_than_or_equal_to: 180,
    message: "Must be a number between 1 and 180" 
  }

  def confirmed?
    status == "CONFIRMADO"
  end

  validate :event_date_is_in_the_future, on: :create

  private

  def event_date_is_in_the_future
    if event_date.present? && event_date <= Time.zone.today
      errors.add(:event_date, "deve ser uma data no futuro")
    end
  end

  def calculate_profit
    if revenue.present? && expense.present?
      self.profit = revenue - expense
    end
  end
end
