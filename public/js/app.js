$(document).ready(function(){
    $('form').on('submit', function(event){
	    event.preventDefault();
	    $('#tab_container').html('');
		$('#tab_container').css('display','block');

		let coeff = $('#term_length').val() == 'months' ? 1 : 12;
		url = '/tabl';
	    $.ajax(url, {
	    		method: 'post',
	    		cache: false,
	    	    data: {months: $('#term').val() * coeff,
	    	           start_date: $('#start_date').val(),
	    	           sum: $('#sum').val(), 
	    	           interest_rate: $('#interest_rate').val(),
	    	           capitalization_method: $('#capitalization').prop('selectedIndex') },
	            dataType: 'html',
	          }).done(function(response) {
	                   $('#tab_container').html(response);
	                 });
    });
});
