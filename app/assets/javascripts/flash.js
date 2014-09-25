var ready;
ready = function() {
	setTimeout(function(){
		$('#flash-notice').fadeOut();
	}, 2000);
};

$(document).ready(ready);
$(document).on('page:load', ready);