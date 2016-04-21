class Api::V1::ApiKeyRevocationsController < ApplicationController
  def create
    render_not_found && return unless valid_api_key?
    api_key.revoke!
    render status: :created, json: {}
  end

  private
  def render_not_found
    render status: :not_found, json: {}
  end

  def valid_api_key?
    api_key && api_key.active?
  end

  def api_key
    ApiKey.find_by_key(params[:api_key])
  end
end
