# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password_digest, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  attr_reader :password

  def self.generate_session_token
    SecureRandom_urlsafe_base64
  end

  def self.reset_session_token
    @session_token = SecureRandom_urlsafe_base64
    self.save!
    self.session_token
  end

  def self.ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.is_password?(password)
    BCrypt::Password.create(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    if user && User.is_password?(password)
      return user
    else
      nil
    end
  end

end
