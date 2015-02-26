class HomeController < ApplicationController
  def index
    @rooms = Room.most_recent.take(1).map do |room|
      RoomPresenter.new room, self, false
    end
  end
end
