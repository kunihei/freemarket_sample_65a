// $(function(){


//   //（１）ページの概念・初期ページを設定
//   var page=0;
  
//   //（２）イメージの数を最後のページ数として変数化
//   var lastPage =parseInt($(".toppage-slider img").length-1);
  
//   //（３）最初に全部のイメージを一旦非表示にします
//        $(".toppage-slider img").css("display","none");
  
//   //（４）初期ページを表示
//             $(".toppage-slider img").eq(page).css("display","block");
  
//   //（５）ページ切換用、自作関数作成
//   function changePage(){
//                            $(".toppage-slider img").fadeOut(1000);
//                            $(".toppage-slider img").eq(page).fadeIn(1000);
//   };
  
//   //（６）～秒間隔でイメージ切換の発火設定
//   var Timer;
//   function startTimer(){
//   Timer =setInterval(function(){
//             if(page === lastPage){
//                            page = 0;
//                            changePage();
//                  }else{
//                            page ++;
//                            changePage();
//             };
//        },5000);
//   }
//   //（７）～秒間隔でイメージ切換の停止設定
//   function stopTimer(){
//   clearInterval(Timer);
//   }
  
//   //（８）タイマースタート
//   startTimer();
  
//   /*オプションを足す場合はここへ記載*/
//   $(".toppage__slider__btnl a").click(function() {
//     //タイマー停止＆スタート（クリックした時点から～秒とする為）
//     stopTimer();
//     startTimer();
//          if(page === lastPage){
//                         page = 0;
//                         changePage();
//               }else{
//                         page ++;
//                         changePage();
//          };
//     });

// //「戻る」をクリック
//     $("toppage__slider__btnr a").click(function() {
//          //タイマー停止＆スタート（クリックした時点から～秒とする為）
//          stopTimer();
//          startTimer();
//          if(page === 0){
//                         page = lastPage;
//                         changePage();
//               }else{
//                         page --;
//                         changePage();
//          };
//     });
  
//   });



