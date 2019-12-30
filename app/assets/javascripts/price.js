$(function(){
  $('.price_calc').on('input', function(){
    var data = $('.price_calc').val();
    var profit = Math.round(data * 0.9)
    var fee = (data - profit)
    $('.value_1').html(fee)
    $('.value_1').prepend('¥')
    $('.value_2').html(profit)
    $('.value_2').prepend('¥')
    $('#price').val(profit) // 計算結果を格納用フォームに追加｡もし､入力値を追加したいのなら､今回はdataを引数に持たせる｡
    if(profit == '') {   // もし､計算結果が''なら表示も消す｡
    $('.value_2').html('');
    $('.value_2').html('');
    }
  })
});