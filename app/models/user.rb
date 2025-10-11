class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

	enum role: { admin: 'ADMIN', user: 'USER' }

  before_validation :normalize_phone

	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true, on: :create
	validates :phone, presence: true, uniqueness: true, length: { is: 11 }

	has_one_attached :photo
	has_many :budgets

	def admin?
		self.role == 'admin'
	end

  def budgets_quantity
    budgets.count
  end

  def normalize_phone
    self.phone = phone.to_s.gsub(/\D/, "")
  end

	def self.from_omniauth(auth)
		user = User.find_or_create_by(uid: auth.uid, provider: auth.provider)
		
		unless user
      user = User.create(
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end

    # Armazenar o access_token, refresh_token e o UID
    user.update(
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      provider: auth.provider,
      uid: auth.uid
    )

    user
  end
end
