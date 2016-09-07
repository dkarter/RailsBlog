class SessionsController < ApplicationController
  helper_method :new_session

  def new

  end

  def create
    session_obj = Session.new(session_params)
    if session_obj.authenticate?
      redirect_to posts_path, flash: { notice: 'Success' }
    else
      redirect_to new_session_path, flash: { error: 'Invalid credentials' }
    end
  end

  private

    def new_session
      Session.new
    end

    def session_params
      params.require(:session).permit(:username, :password)
    end
end
