class Review < ApplicationRecord
    validates :customer_name, presence: true
    
end
