module TakeHome
  class Client
    include HTTParty

    base_uri "https://takehome.io"
    format :json

    def initialize
    end

    def twitter_data(options = {})
      self.class.get('/twitter', { query: options }).parsed_response
    end

    def facebook_data(options = {})
      self.class.get('/facebook', { query: options }).parsed_response
    end

    def instagram_data(options = {})
      self.class.get('/instagram', { query: options }).parsed_response
    end
  end
end
