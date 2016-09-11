class User < ApplicationRecord
  def valid_password?(password)
    BCrypt::Password.new(password_digest) == password
  end

  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
  end

  def locked_out?
    locked_out_timestamp.present? &&
      locked_out_timestamp < Date.tomorrow
  end

  def record_bad_login!
    if (failed_login_attempts + 1) >= 3
      update(locked_out_timestamp: Date.today)
    else
      update(failed_login_attempts: failed_login_attempts + 1)
    end
  end

  def reset_login_attempts!
    update(failed_login_attempts: 0)
  end
end
