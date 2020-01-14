$(window).on("turbolinks:load",function() {
  $('.link2').on('submit', function(e){
    // 通常のsubmitイベントを止める
    e.preventDefault();
  });
});