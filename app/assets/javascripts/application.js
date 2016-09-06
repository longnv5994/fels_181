// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .

$(document).ready(function(){
  var word_attribute_index = 0;
    $('#btn').click(function(){
      $('ol').append(
        "<div class='tr-ans-"+word_attribute_index+" tr-ans'>"
        + "<div class='col-md-7'>"
        + "<label for='word_word_answers_attributes_"
        + word_attribute_index
        + "_word_answer'></label>"
        + "<input type='text' name='word[word_answers_attributes]["
        + word_attribute_index
        + "][content]' id='word_word_answers_attributes_"
        + word_attribute_index
        + "_content'>"
        + "</div>"
        + "<div class='checkbox col-md-2'>"
        + "<label><input value='true' type='radio' name='word[word_answers_attributes][0][is_correct]' >correct</label>"
        + "</div>"
        + "<div class='deletebox col-md-2'>"
        + "<label><a href='javascript:;' class='btn-delete-ans' data-id='"
        + word_attribute_index
        + "' type='button'>delete</a></label>"
        + "</div>"
        + "</div>"
      );
    word_attribute_index++;
  });

  $('.grid-answer').on('click','.btn-delete-ans',function(event){
    var id = $(this).data("id");
    $(".tr-ans-"+id).remove();
    event.preventDefault();
  })

});

$(document).on('ready page:load', function() {
  loadPageBody($('#grid-content'),$('#btnsearch').data('url'));
  $('.grid-word').on('click','#btnsearch',function(){
    console.log('fgf');
    loadPageBody($('#grid-content'),$(this).data('url'));
  })

  $('.txtkeyword').keypress(function(e) {
    if(e.which == 13) {
      event.preventDefault();
      $('#btnsearch').trigger('click');
    }
  });
})

function loadPageBody($container, url, data) {
  try {
    var dataseri = $('form').serialize();
    $container.html("<img src='/assets/images/loading.gif' />");
    var dfd = $.Deferred();
    $container.load(url, dataseri, function (response, status, xhr) {
      if (status == 'error') {
        var msg = I18n.t("status.errors") + xhr.status + " " + xhr.statusText;
        $container.html(msg);
      }
      return dfd.resolve();
    });
    return dfd.promise();
  } catch (e) {
    $container.html(e.message);
  }
}
