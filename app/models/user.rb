class User < ApplicationRecord
  USER_PARAMS = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
    length: {maximum: Settings.user.name.length.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.length.maximum},
    format: {with: Settings.user.email.VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.user.password.length.minimum}

  has_secure_password

  before_save :downcase_email

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
