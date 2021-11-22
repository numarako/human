class EventsController < ApplicationController
  before_action :set_event, only: [:update, :destroy]

  def index
    @events = Event.where(user_id: params[:id])
    # mindカラムの値を日本語化
    # @events.each{|event| event.mind = event.mind_i18n }
    # インスタンスをJSに渡す処理
    gon.event_array = @events.map{|event| event }
  end

  def new
    @event = Event.new
    @event.date = new_event_date_params[:date]
  end

  def edit
    @event = Event.find_by(id: target_id_params[:target_id])
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "カレンダー追加が完了しました!"
      redirect_to index_events_path(current_user)
    else
      render 'new'
    end
  end

  def update
    if @event.update(event_params)
      flash[:success] = "カレンダーを更新しました！"
      redirect_to index_events_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "カレンダーを削除しました！"
    redirect_to index_events_path(current_user)
  end

  private
  def new_event_date_params
    params.permit(:date)
  end

  def target_id_params
    params.permit(:target_id)
  end

  def event_params
    params.require(:event).permit(:mind, :reason, :small_success, :date)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
