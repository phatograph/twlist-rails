class HomeController < ApplicationController
  def index
    @next_cursor = -1
  end

  def list
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

  def lists_ownerships
    lists_res = twitter.lists_ownerships(params[:id])
    lists = lists_res['lists'].map do |list|
      {
        :name => list['name'],
        :url => list_url(list['id'])
      }
    end

    respond_to do |format|
      format.json do
        render :json => {
          :lists => lists,
          :next_cursor => lists_ownerships_url(lists_res['next_cursor'], :format => :json)
        }.to_json
      end
    end
  end

  def lists_members_all
    cursor = -1
    all_members = []

    while cursor != 0
      res = twitter.lists_members(params[:id], cursor)

      all_members += res['users'].map do |member|
        {
          :name => member['name']
        }
      end

      cursor = res['next_cursor']
    end

    respond_to do |format|
      format.json do
        render :json => {
          :members => all_members
        }.to_json
      end
    end
  end

  def lists_members
    res = twitter.lists_members(params[:id], params[:cursor] || -1)
    members = res['users'].map do |member|
      {
        :name => member['name']
      }
    end

    respond_to do |format|
      format.json do
        render :json => {
          :members => members,
          :next_cursor => lists_members_url(params[:id], res['next_cursor'], :format => :json)
        }.to_json
      end
    end
  end
end
