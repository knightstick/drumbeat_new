# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
placeholder = (id) ->
  $(id).attr('placeholder')

placeholderPresent = (id) ->
  placeholder(id).length > 0
  
$(document).ready ->
  if placeholderPresent '#score4'
    if placeholderPresent '#score60'
      if placeholderPresent '#score5'
        # all scores set
        $('.all-scores').show()
        $('.score4-present').show()
        $('.score60-present').show()
      else
        # both 4 and 60 set, but not 5
        $('.no-score5').show()
        $('#score4-form').removeClass('col-md-offset-2')
        $('.score4-present').show()
        $('.score60-present').show()
    else
      # 4 but not 60 set
      $('.no-score60').show()
      $('.score4-present').show()
      $('#score4-form').addClass('col-md-offset-2')
  else
    # no scores set
    $('.no-score4').show()
    $('#score4-form').addClass('col-md-offset-4')

      

  