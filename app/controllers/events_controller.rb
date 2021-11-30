class EventsController < ApplicationController
  before_action :logged_in_user
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :correct_event, only: [:edit, :update, :destroy]

  def index
    @events = current_user.events
    gon.event_array = @events.map{|event| event }
  end

  def new
    @event = Event.new
    @event.date = new_event_date_params[:date]
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "カレンダーを追加しました! ~あなたが幸せでありますように~"
      redirect_to events_path
    else
      render 'new'
    end
  end

  def update
    if @event.update(event_params)
      flash[:success] = "カレンダーを更新しました！ ~あなたが幸せでありますように~"
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "カレンダーを削除しました！"
    redirect_to events_path
  end
  
  private
    def new_event_date_params
      params.permit(:date)
    end

    def event_params
      params.require(:event).permit(:mind, :reason, :small_success, :small_thanks, :date)
    end

    # 更新系アクションで利用するインスタンスを生成
    def set_event
      @event = Event.find(params[:id])
    end

    # 更新系アクションの対象が正しいか確認
    def correct_event
      @event = current_user.events.find_by(id: params[:id])
      if @event.nil?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
