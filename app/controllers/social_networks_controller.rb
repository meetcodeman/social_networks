class SocialNetworksController < ApplicationController
  def index
    data = TakeHomeService.new.data
    render json: data, status: 200
  rescue JSON::ParserError
    render json: 'Server responded with Invalid JSON', status: 422
  end
end
