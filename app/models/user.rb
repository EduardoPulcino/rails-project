class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	enum role: { admin: 'ADMIN', user: 'USER' }

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	validates :phone, presence: true, uniqueness: true

	has_one_attached :photo
	has_many :budgets
end
