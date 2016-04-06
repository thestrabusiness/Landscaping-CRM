# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#payment_client_name').autocomplete
    source: $('#payment_client_name').data('autocomplete-source')
    select: (event, ui) ->
      $( "#payment_client_name" ).val( ui.item.label );
      $( "#payment_client_id" ).val( ui.item.id );