$(document).ready(function() {
	$('#form_tweet').on("submit", function(e){
		e.preventDefault();
		$('#loading_image').html("<img src='ajax-loader.gif'>");
		$.post('/tweet', $('input[name=tweet]').serialize()).done(function(response){
			$('#loading_image').html(response);
			$('#form_tweet')[0].reset();
		});
	});
});
