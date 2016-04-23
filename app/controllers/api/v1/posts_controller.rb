class Api::V1::PostsController < ApplicationController
  def create
    render_unauthorized && return unless authorized?
    render_bad_request && return unless params[:message]
    render_created!
  end

  private
  def render_created!
    user.posts.create!(message: params[:message])
    render status: :created, json: {}
  end

  def render_bad_request
    render status: :bad_request, json: {}
  end

  def render_unauthorized
    render status: :unauthorized, json: {}
  end

  def api_key
    ApiKey.find_by(key: params[:api_key])
  end

  def user
    api_key.user
  end

  def authorized?
    api_key && api_key.active?
  end
end
