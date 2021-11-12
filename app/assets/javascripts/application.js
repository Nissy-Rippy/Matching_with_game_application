// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.raty.js
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


//ターボリンクスを再読み込みするように設定している。
$(document).on('turbolinks:load', function () {
  // 初期画像の表示をここする
  let index = 0;
  // addclassで(main-img)に(current-img)のクラスを追加している。
  $('.main-img').eq(index).addClass('current-img');
  // setIntervalにより一定のタイムングで特定の処理を行うようにしている。
  setInterval(function () {
    // (current-img)のクラスを取り除いている。
    $('.main-img').eq(index).removeClass('current-img');
    // 画像の最後判定
    if (index == $('.main-img').length - 1) {
      index = 0;
    } else {
      index++;
    }
    // 取り除いたあとにまた、クラスを付け加えている。
    $('.main-img').eq(index).addClass('current-img');
  }, 3000);
});