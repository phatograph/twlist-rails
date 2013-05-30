class HomeController < ApplicationController
  def index
    twitter = PoormanTwitter.new

    followings_ids = twitter.followings
    followings = twitter.users_lookup(followings_ids['ids'].join(','))
    followings.each do |f|
      puts f['name']
    end
  end
end
