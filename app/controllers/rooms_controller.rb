class RoomsController < ApplicationController
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    # O método #map, de coleções, retornará um novo Array
    # contendo o resultado do bloco. Dessa forma, para cada quarto,
    # retornaremos o presenter equivalente
    @rooms = Room.most_recent.map do |room|
      # Não exibiremos o formulário na listagem
      RoomPresenter.new room, self, false
    end
  end

  def show
    room_model = Room.find params[:id]
    @room = RoomPresenter.new room_model, self
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.build room_params

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render :new 
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated') 
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: t('flash.notice.room_excluded')
  end

  private
    def set_room
      @room = current_user.rooms.find params[:id]
    end

    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
