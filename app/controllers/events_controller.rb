class EventsController < ApplicationController
  def index
    @events = Event.where(user_id: params[:id])
    # mindカラムの値を日本語化
    # @events.each{|event| event.mind = event.mind_i18n }
    # インスタンスをJSに渡す処理
    gon.event_array = @events.map{|event| event }
  end
end
