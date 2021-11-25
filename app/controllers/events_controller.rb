class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:index]
  before_action :logged_in_user, only: [:create] # actionの中でcorrect_userを指定
  before_action :correct_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.where(user_id: params[:id])
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
      flash[:success] = "カレンダーを追加しました!"
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

    def event_params
      params.require(:event).permit(:mind, :reason, :small_success, :small_thanks, :date)
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def correct_event
      @event = current_user.events.find_by(id: params[:id])
      if @event.nil?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
