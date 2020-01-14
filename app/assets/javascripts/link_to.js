$(window).on("turbolinks:load",function() {
  $('.link2').on('linl_to', function(e){
    // 指定のlink_toのイベントを止める
    e.preventDefault();
  });
});