class Api::V1::BaseController < ApplicationController
  abstract!

  protect_from_forgery with: :null_session

  respond_to :json
end
