class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, if: -> { !request.format.json? }
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
