// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    $('.collapsible .collapsible-content').hide();
    $('.collapsible a.collapsible-title').each(function(idx, elem){elem.href ="#";});
    $('.collapsible a.collapsible-title').click(function(){
      $('.collapsible .collapsible-content').toggle();
      return false;
    });


    $('.auto-focused').focus();

    var buttons = $('input[type="button"]').add('input[type="submit"]').add('button');
    buttons.addClass('ui-button ui-widget ui-state-default ui-corner-all');
});
