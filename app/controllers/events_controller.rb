class EventsController < ApplicationController
  def index
    @events = Event.where(user_id: params[:id])
    # mindカラムの値を日本語化
    # @events.each{|event| event.mind = event.mind_i18n }
    # インスタンスをJSに渡す処理
    gon.event_array = @events.map{|event| event }
  end

  def create
    # 
    @event = Event.create!(user_id: params[:id], mind: params[:mind], reason: params[:reason], small_success: params[:small_success], date: params[:date])
  end
 
  #private
  #def event_params
  #  params.require(:event).permit(:user_id, :mind, :reason, :small_success, :date)
  #end
end
