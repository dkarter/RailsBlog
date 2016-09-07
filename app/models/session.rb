class Session
  include ActiveModel::Model

  attr_accessor(
    :username,
    :password,
  )

  def authenticate?
    user = User.find_by(email: username)
    user && user.valid_password?(password)
  end
end
