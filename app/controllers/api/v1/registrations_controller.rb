class Api::V1::RegistrationsController < ApplicationController
  def create
    render_bad_request && return if params_missing?
    render_created
  end

  private

  def render_bad_request
    render status: :bad_request, json: {}
  end

  def render_created
    User.create!(registration_params)
    render status: :created, json: {}
  end

  def params_missing?
    !(registration_params[:email] && registration_params[:password])
  end

  def registration_params
    params.require(:registration).permit(:email, :password)
  end
end
