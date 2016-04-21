class Api::V1::ApiKeysController < ApplicationController
  def create
    render_bad_request && return if params_missing?
    render_unauthorized && return unless authenticated_user
    render_created!
  end

  private

  def render_created!
    key = authenticated_user.api_keys.create!
    render status: :created, json: {key: key.key}
  end

  def render_unauthorized
    render status: :unauthorized, json: {}
  end

  def render_bad_request
    render status: :bad_request, json: {}
  end

  def params_missing?
    !(credentials[:email] && credentials[:password])
  end

  def authenticated_user
    email, password = credentials[:email], credentials[:password]
    user = User.find_by(email: email)
    user.authenticate(password) if user
  end

  def credentials
    params.require(:credentials).permit(:email, :password)
  end
end
