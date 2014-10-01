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
      	allScoresSet()
      else
        # both 4 and 60 set, but not 5
      	set4and60()
    else
      # 4 but not 60 set
      set4Not60()
  else
    # no scores set
  	noScoresSet()

      
allScoresSet = ->
	$('.all-scores').show()
	$('.score4-present').show()
	$('.score60-present').show()

set4and60 = ->
	$('.no-score5').show()
	$('#score4-form').removeClass('col-md-offset-2')
	$('.score4-present').show()
	$('.score60-present').show()

set4Not60 = ->
	$('.no-score60').show()
	$('.score4-present').show()
	$('#score4-form').addClass('col-md-offset-2')

noScoresSet = ->
	$('.no-score4').show()
	$('#score4-form').addClass('col-md-offset-4')