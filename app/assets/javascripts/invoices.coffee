# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  jQuery ->
    $('#invoice_client_name').autocomplete
      source: $('#invoice_client_name').data('autocomplete-source')
      select: (event, ui) ->
        $( "#invoice_client_name" ).val( ui.item.label );
        $( "#invoice_client_id" ).val( ui.item.id );

$(document).ready(ready)
$(document).on('page:load', ready)