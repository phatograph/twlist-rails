class PoorManTwitter
  def initialize
    consumer_key = ENV['CONSUMER_KEY']
    consumer_secret = ENV['CONSUMER_SECRET']
    access_token = ENV['ACCESS_TOKEN']
    access_token_secret = ENV['ACCESS_TOKEN_SECRET']

    consumer = OAuth::Consumer.new(
      consumer_key,
      consumer_secret,
      {
        :site => "http://api.twitter.com",
        :scheme => :header
      }
    )

    token_hash = {
      :oauth_token => access_token,
      :oauth_token_secret => access_token_secret
    }

    @access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def home_timeline
    res = @access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
    JSON.parse(res.body)
  end

  def followings
    res = @access_token.request(:get, "https://api.twitter.com/1.1/friends/ids.json?screen_name=phatograph")
    JSON.parse(res.body)
  end
end

class HomeController < ApplicationController
  def index
    twitter = PoorManTwitter.new
    puts twitter.followings.to_yaml
  end
end
