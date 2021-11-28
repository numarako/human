// fullcalender追加対応
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function () {
  $.get("https://holidays-jp.github.io/api/v1/date.json", function (holidaysData) {
    var calendarEl = document.getElementById('calendar');
    if (calendarEl) {
      // calendar要素の取得に成功した場合、カレンダーデータを作成して画面に表示する
      var calendar = new Calendar(calendarEl,
        {
          plugins: [dayGridPlugin, interactionPlugin],
          // 日本語化対応
          locale: 'ja',
          buttonText: {
            today: '今日'
          },
          // modal
          selectable: true,
          dateClick: function (info) {
            var new_event_date = info.dateStr;
            window.location.href = `/events/new/?date=${new_event_date}`;
          },

          eventClick: function (info) {
            var target_id = info.event._def.extendedProps.diary_id;
            window.location.href = `/events/${target_id}/edit`;
          },

          // イベント予定設定
          events: getEventDates(holidaysData),

          //  イベント予定毎の初期化設定(日付けとクラス付与)
          eventContent: function (arg) {
            // 祝日のイベント
            if (arg.event.extendedProps.holiday_date) {
              $('.fc-daygrid-day[data-date=' + arg.event.extendedProps.holiday_date + ']').addClass("holiday");
              // 個人のイベント
            } else if (arg.event.extendedProps.diary_date) {
              $('.fc-daygrid-day[data-date=' + arg.event.extendedProps.diary_date + ']').addClass("diary");
            }
          },
        });
      calendar.render();
    } else {
      // calendar要素の取得に失敗した場合、処理を行わない
    }
  });
});

// イベント予定取得
function getEventDates(holidaysData) {
  var eventDatas = [];

  // 祝日
  var holidays = Object.keys(holidaysData);
  for (var i = 0; i < holidays.length; i++) {
    var holiday =
    {
      // 指定日付セル内の表示内容
      title: holidaysData[holidays[i]],
      // 指定日付
      start: holidays[i],
      // クラス名
      className: "holiday",
      holiday_date: holidays[i],
      color: 'transparent',
    };
    eventDatas.push(holiday);
  }
  // 個人のイベント
  var diaries = gon.event_array;
  for (var i = 0; i < diaries.length; i++) {
    // mindの値に応じてイベントの色を変更する
    var color;
    var title;
    switch (diaries[i].mind) {
      case "sunny":
        // 鮮やかな赤みの橙色
        color = '#FF6E00';
        title = '🌞🌞🌞快晴'
        break;
      case "clear":
        // orange
        color = '#FFA500';
        title = '🌞晴天'
        break;
      case "fine":
        // 鮮やかな赤みの黄
        color = '#FFDE00';
        title = '🌤晴れ'
        break;
      case "cloudy":
        // silver
        color = '#C0C0C0';
        title = '🌥曇り'
        break;
      case "rainy":
        // 鮮やかな青
        color = '#00A2FF';
        title = '☔雨'
        break;
    }
    // 個人の各イベントを設定
    var diary =
    {
      // 指定日付セル内の表示内容
      title: title,
      // 指定日付
      start: diaries[i].date,
      // クラス名
      className: "diary",
      diary_date: diaries[i].date,
      color: color,

      // idカラム
      diary_id: diaries[i].id,
    };
    eventDatas.push(diary);
  }
  return eventDatas;
}
