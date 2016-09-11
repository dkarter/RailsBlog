class SessionsController < ApplicationController
  def new

  end

  def create
    session_obj = Session.new(session_params)
    user = session_obj.user

    if user.try(:locked_out?)
      err = 'Account locked out. Please try again later.'
      redirect_to new_session_path, flash: { error: err }
    elsif session_obj.authenticate?
      user.reset_login_attempts!
      redirect_to posts_path, flash: { notice: 'Success' }
    else
      user.try(:record_bad_login!)
      redirect_to new_session_path, flash: { error: 'Invalid credentials' }
    end
  end

  private

    def session_params
      params.require(:session).permit(:username, :password)
    end
end
