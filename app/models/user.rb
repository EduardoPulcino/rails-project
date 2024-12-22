class User < ApplicationRecord
    enum role: { admin: 'ADMIN', user: 'USER' }

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :phone, presence: true, uniqueness: true

    has_one_attached :photo
end
