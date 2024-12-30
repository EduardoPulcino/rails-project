class EventType < ApplicationRecord
    has_many :reviews
    has_many :budgets
    has_many :decorations
    validates :name, presence: true
end
