class User < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.user.name.length.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.length.maximum},
    format: {with: Settings.user.email.VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.user.password.length.minimum}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
