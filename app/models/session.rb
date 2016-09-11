class Session
  include ActiveModel::Model

  attr_accessor(
    :username,
    :password,
  )

  def authenticate?
    user && user.valid_password?(password)
  end

  def user
    @user ||= User.find_by(email: username)
  end
end
