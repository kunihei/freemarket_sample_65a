$(function(){
  $(".toppage-slider").slick({
    autoplay: true,
    autoplaySpeed: 5000,
    arrows: true,
    appendArrows: $('.toppage-slider'),
    prevArrow: '<i class="fas fa-chevron-left", id="slick-prev" ></i>',
    nextArrow: '<i class="fas fa-chevron-right", id="slick-next"></i>',
    dots: true,
    infinite: true,
    speed: 1000,
    slidesToShow: 1,
    adaptiveHeight: true,
    fade: false,
  })
})