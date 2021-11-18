// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"

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
          // イベント予定設定
          events: getEventDates(holidaysData),
          //  イベント予定毎の初期化設定
          eventContent: function (arg) {
            $('.fc-daygrid-day[data-date=' + arg.event.extendedProps.holiday + ']').addClass("holiday");
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
      // カラー表示
      color: '#8FBC8F',
      // クリック時の遷移先
      url: 'https://www.w2solution.co.jp/tech/2021/02/21/fullcalendar%E4%BD%BF%E3%81%84%E6%96%B9/',
      // クラス名
      className: "holiday"
      , holiday: holidays[i],
    };
    eventDatas.push(holiday);
  }
  return eventDatas;

  var notes = gon.event_array;
  for (var i = 0; i < notes.length; i++) {
    var note =
    {
      // 指定日付セル内の表示内容
      title: notes[i].mind,
      // 指定日付
      start: notes[i].date,
      // カラー表示
      color: '#8FBC8F',
      // クリック時の遷移先
      url: 'https://www.w2solution.co.jp/tech/2021/02/21/fullcalendar%E4%BD%BF%E3%81%84%E6%96%B9/',
      // クラス名
      className: "note"
    };
    eventDatas.push(note);
  }
  return eventDatas;

}
