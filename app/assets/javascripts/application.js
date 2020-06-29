// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree



//    検索フォーム
//    $(document).ready(function() {
//       $('.nice-textbox').blur(function() {
//            if($(this).val().length === 0){
//              $('.nice-label').removeClass("focus");
//            }
//            else { returns; }
//          })
//          .focus(function() {
//            $('.nice-label').addClass("focus")
//          });
//    });
      
// セレクトボックス、プルダウン

$(document).on('turbolinks:load', function(){
$(window).scroll(function() {
    $(".animation .anm_mod").each(function() {
     const position = $(this).offset().top;
     const scroll = $(window).scrollTop();
     const windowHeight = $(window).height();
     if (scroll > position - windowHeight) {
      $(this).addClass("active");
     }
     if (scroll < 100) {
      $(this).removeClass("active");
     }
    });
   });
   
   $(function() {
    $('a[href^="#"]').click(function() {
     const speed = 800;
     const href = $(this).attr("href");
     const target = $(href == "#" || href == "" ? "html" : href);
     const position = target.offset().top;
     $("html, body").animate({ scrollTop: position }, speed, "swing");
     return false;
    });
   });
});