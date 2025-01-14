class Review < ApplicationRecord
    belongs_to :event_type

    validates :customer_name, :event_type, :text, presence: true
end
