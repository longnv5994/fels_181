
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
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  var answers = document.getElementsByClassName("answer_field");
  if (answers.length < 5){
    $('.new_answer').append(content.replace(regexp, new_id));
  } else {
    alert(I18n.t("max_answer"))
  }
}

function remove_fields(link) {
  $(link).parent().find('input[type=hidden]').val('1');
  var answer = $(link).parent().parent().hide();
  $(answer).hide();
}

$(document).on('ready page:load', function() {
  loadPageBody($('#grid-content'),$('#btnsearch').data('url'));
  $('.grid-word').on('click','#btnsearch',function(){
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
