class User < ApplicationRecord
  def valid_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
  end
end
