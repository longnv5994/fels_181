
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
  console.log(answers.length);
  if(answers.length < 4 ) {
    $('.new_answer').append(content.replace(regexp, new_id));
  }
  else {
    alert(I18n.t("max_answers"));
  }
}

function remove_fields(link) {
  var answer = $(link).parent().parent();
  var answers = document.getElementsByClassName("answer_field");
  console.log(answers.length);
  if(answers.length > 2 ) {
    $(link).parent().find('input[type=hidden]').val('1');
    answers[answer.length - 1].removeAttribute("class");
    $(answer).hide();
  }
  else {
    alert(I18n.t("min_answers"));
  }
}

$(document).on('ready page:load', function() {
  loadPageBody($('#grid-content'),$('#btnsearch').data('url'));
  $('.grid-word').on('click','#btnsearch',function(){
    var dataseri = $('form').serialize();
    loadPageBody($('#grid-content'),$(this).data('url'),dataseri);
  })
  $('.txtkeyword').keypress(function(e) {
    if(e.which == 13) {
      event.preventDefault();
      $('#btnsearch').trigger('click');
    }
  });

  $('.btn-follow').click(function(e){
    var link = $(this).hasClass("follow") ? "follow" : "unfollow";
    var method = $(this).hasClass("follow") ? "POST" : "DELETE";
    $btnfollow = $(this);
    $.ajax({
      url: $(this).data(link),
      data: {id: $(this).data("id")},
      method: method
    }).done(function(data) {
      if($btnfollow.hasClass("follow")){
        $btnfollow.removeClass("follow btn-success");
        $btnfollow.addClass("unfollow btn-info");
        $btnfollow.text(I18n.t("unfollow"));
      }
      else {
        $btnfollow.addClass("follow btn-success");
        $btnfollow.removeClass("unfollow btn-info");
        $btnfollow.text(I18n.t("follow"));
      }
    });
    e.preventDefault();
  });

  $('.grid-word').on('click','.filter-lesson ul.pagination li a', function(e){
    var dataseri = $('form').serialize();
    dataseri = dataseri + "&page=" + $(this).text();
    loadPageBody($('#grid-content'), $('#btnsearch').data('url'), dataseri);
    e.preventDefault();
  })

  $('a.act-view').click(function (event) {
    var $grid = $(this).closest("div.grid-data");
    var datapost = $grid.data("parameters");
    if (datapost == 'undefined') {
      datapost = {}
    }
    var dataFinish = {};
    $.extend(dataFinish, datapost);
    openDialogView('Info', $(this).data('view'), datapost, $grid.data("size"));
    event.stopPropagation();
  })

  $('.content-main').on('change','.radio_answer',function() {
    $('.radio_answer').prop('checked', false);
    $(this).prop('checked', true);
  });

  $('.alert').fadeOut(3000);

});

function loadPageBody($container, url, data) {
  try {
    var dataseri = $('form').serialize();
    if(data == undefined)
      data = dataseri;
    $container.html("<img src='/assets/images/loading.gif' />");
    var dfd = $.Deferred();
    $container.load(url, data, function (response, status, xhr) {
      if (status == 'error') {
        var msg = I18n.t("status.errors") + xhr.status + " " + xhr.statusText;
        $container.html(msg);
      }
      $('.grid-word ul.pagination li.prev,.grid-word ul.pagination li.next').css("display","none");
      return dfd.resolve();
    });
    return dfd.promise();
  } catch (e) {
    $container.html(e.message);
  }
}

function openDialogView(stitle, urlpageLoad, data, size) {
  try {
    var $container = $("<div></div>");
    loadPage($container, urlpageLoad, data).done(function () {
      var $dialog = BootstrapDialog.show({
        title: stitle,
        onshown: function (dialogRef) {
        },
        message: $container,
        closable: true,
        closeByBackdrop: false,
        draggable: true,
        buttons: [
        {
          label: I18n.t("exit"),
          action: function (dialogRef) {
            dialogRef.close();
          }
        }],
      });

      if (size == 'NORMAL')
        $dialog.setSize(BootstrapDialog.SIZE_NORMAL);
      else if (size == 'SMALL')
        $dialog.setSize(BootstrapDialog.SIZE_SMALL);
      else if (size == 'LARGE')
        $dialog.setSize(BootstrapDialog.SIZE_LARGE);
      else if (size == 'FULL') {
        $dialog.setSize(BootstrapDialog.SIZE_FULL);
      }
      else
        $dialog.setSize(BootstrapDialog.SIZE_WIDE);
      $dialog.open();
    })
  } catch (e) {}
}

function loadPage($container, url, data) {
  $container.html("<img src='/assets/images/loading.gif' />");
  var dfd = $.Deferred();
  $container.load(url, data, function (response, status, xhr) {
    if (status == 'error') {
      var msg = I18n.t('status.errors ') + xhr.status + " " + xhr.statusText;
      $container.html(msg);
    }
    return dfd.resolve();
  });
  return dfd.promise();
}
