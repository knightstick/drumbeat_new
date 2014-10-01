# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
placeholder = (id) ->
  $(id).attr('placeholder')

placeholderPresent = (id) ->
  placeholder(id).length > 0

buildScoreButtons = ->
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


noScoresSet = ->
	$('.no-score4').show()
	$('#score4-form').addClass('col-md-offset-4')
	$('#score4-form .btn').on "click", ->
		if $('#score4').val().length > 0
			set4Not60()

set4Not60 = ->
	$('.no-score4').hide()
	$('.no-score60').show()
	$('.score4-present').show()
	$('#score4-form').removeClass('col-md-offset-4')
	$('#score4-form').addClass('col-md-offset-2')
	$('#score60-form .btn').on "click", ->
		if $('#score60').val().length > 0
			set4and60()

set4and60 = ->
	$('.no-score60').hide()
	$('.no-score5').show()
	$('#score4-form').removeClass('col-md-offset-2')
	$('.score4-present').show()
	$('.score60-present').show()
	$('#score60-form').find('btn').off
	$('#score5-form .btn').on "click", ->
		if $('#score5').val().length > 0
			allScoresSet()

allScoresSet = ->
	$('.no-score5').hide()
	$('.all-scores').show()
	$('.score4-present').show()
	$('.score60-present').show()

ScoreButton = (id) ->
  @name = id.substring(1)
  @currentScore = $(id).attr("placeholder")
  @button = $("#{id}-form .btn")
  @grabScore = () ->
    return $(id).val()
  @isHighScore = () ->
    if @currentScore < @grabScore()
      return true
    else
      return false
    return
  @postScore = () ->
    if @isHighScore()
      @currentScore = $(id).attr("placeholder")
      sendMe = {}
      sendMe[@name] = @grabScore()
      $.ajax(
        url: postUrl
        data: sendMe
        type: 'POST'
      )
    return
  return

$ ->
	buildScoreButtons()
	button4 = new ScoreButton('#score4')
	button60 = new ScoreButton('#score60')
	button5 = new ScoreButton('#score5')
	button4.button.on "click", ->
		button4.postScore()
	button60.button.on "click", ->
		button60.postScore()
	button5.button.on "click", ->
		button5.postScore()
