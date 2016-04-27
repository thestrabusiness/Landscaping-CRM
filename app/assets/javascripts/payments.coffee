# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->

  jQuery ->
    $('#payment_client_name').autocomplete
      source: $('#payment_client_name').data('autocomplete-source')
      select: (event, ui) ->
        $( "#payment_client_name" ).val( ui.item.label );
        $( "#payment_client_id" ).val( ui.item.id );
        
    $('#payment_invoice_id').autocomplete
      source: $('#payment_invoice_id').data('autocomplete-source')
      select: (event, ui) ->
        $( "#payment_invoice_id" ).val( ui.item.label );
        $( "#payment_invoice_id" ).val( ui.item.id );
    
        
$(document).ready(ready)
$(document).on('page:load', ready)