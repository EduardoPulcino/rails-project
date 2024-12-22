class Review < ApplicationRecord
    belongs_to :event_type

    validates :customer_name, :event_type, presence: true
end
