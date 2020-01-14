$(function() {
  // タブのDOM要素を取得し、変数で定義
  let tabs = $(".mypage__item");

  // クラスの切り替えをtabSwitch関数で定義
  function tabSwitch() {
 
    // 全てのactiveクラスのうち、最初の要素を削除（"[0]は、最初の要素の意味"）
    $(".active").removeClass("active");

    // クリックしたタブにactiveクラスを追加

    $(this).addClass("active");

    // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
    const index = tabs.index(this);

    // クリックしたタブに対応するshowクラスを追加する
    $(".mypage__content").removeClass("show").eq(index).addClass("show");
  }
  // aタグの打ち消し
  tabs.click(function(event){
    event.preventDefault();
  });
  // タブがクリックされたらtabSwitch関数を呼び出す
  tabs.click(tabSwitch);    
});



$(window).on("turbolinks:load",function()  {
  // タブのDOM要素を取得し、変数で定義
  let tabs = $(".mypage__item__bottom");

  // クラスの切り替えをtabSwitch関数で定義
  function tabSwitch() {

    
    // 全てのactiveクラスのうち、最初の要素を削除
    $(".actives").removeClass("actives");

    // クリックしたタブにactiveクラスを追加

    $(this).addClass("actives");

    // 何番目の要素がクリックされたかを、配列tabsから要素番号を取得
    const index = tabs.index(this);

    // クリックしたタブに対応するshowクラスを追加する
    $(".mypage__content__bottom").removeClass("show").eq(index).addClass("show");
  }
  // aタグの打ち消し
  tabs.click(function(event){
    event.preventDefault();
  });
  // タブがクリックされたらtabSwitch関数を呼び出す
  tabs.click(tabSwitch);    
});



$(window).on("turbolinks:load",function()  {
    $('.newuser__body__content__reveal__space').toggle();
  $('#check1').click(function(){
    $('.newuser__body__content__reveal__space').toggle();
  });
});



$(window).on("turbolinks:load",function()  {
  var $input = $('#input');
  var $output = $('#output');
  $input.on('input', function(event) {
    var value = $input.val();
    $output.text(value);
  });
});