var ready;
ready = function() {
	setTimeout(function(){
		$('#flash-notice').fadeOut();
		$('#flash-success').fadeOut();
	}, 1500);
};

$(document).ready(ready);
$(document).on('page:load', ready);