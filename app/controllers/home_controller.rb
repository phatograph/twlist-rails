class HomeController < ApplicationController
  def index
    @next_cursor = -1
  end

  def users_followings
    followings_res = twitter.followings(params[:cursor] || -1)
    followings = twitter.users_lookup(followings_res['ids'].join(',')).map do |following|
      following['name']
    end

    respond_to do |format|
      format.json do
        render :json => {
          :followings => followings,
          :next_cursor => users_followings_url(followings_res['next_cursor'], :format => :json)
        }.to_json
      end
    end
  end
end
