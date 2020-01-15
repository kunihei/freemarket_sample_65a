$(function(){
  function buildHTML(comment){
    var html = `<li class="item-comments__comment">
                  <img class="item-comments__comment--imagephoto" src="https://bepo-blog.com/wp-content/uploads/2019/08/nikorun.jpg" width="30" height="30">
                  <div class="item-comments__comment__body">
                    <div class="item-comments__comment__body--text">
                      ${comment.text}
                    </div>
                    <time class="item-comments__comment__body__time">
                      <i class="fas fa-clock icon-clock"></i>
                      <span class="item-comments__comment__body__time--date">
                        ${comment.created_at}
                      </span>
                    </time>
                  </div>
                </li>`
    return html;
  }
  $('#new_t_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comment-item-container').append(html);
      $('.comment-message2').val('');
      $('.comment-submit2').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
});


