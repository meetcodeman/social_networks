require 'take_home/client'

class TakeHomeService
  attr_reader :client

  def initialize
    @client = TakeHome::Client.new
  end

  def data
    {
      tweets: client.twitter_data,
      facebook: client.facebook_data,
      instagram: client.instagram_data
    }
  end
end
