/*$(document).ready(function(){
  $(".fas").click(function(){
    $(this).hide();
  });
});
*/
// var id1=0

$(document).ready(function(){
	
	$('#new_project_form').submit(function(){
		var user_ids = [];
		var selected_users = $("i[class*='selected']");
		selected_users.each(function(){
			user_ids.push($(this).attr('id').split('_').pop());
		});
		$('#selected_users').val(user_ids);
	});


	$('#edit_project_form').submit(function(){
		var user_ids = [];
		var selected_users = $("i[class*='selected']");
		selected_users.each(function(){
			user_ids.push($(this).attr('id').split('_').pop());
		});
		$('#selected_users').val(user_ids);
	});


	$('[id^="bugzilla_user_"]').click(function() {
		var id = $(this).attr('id');
		var user_id = id.split("_").pop();
		
		$(this).hasClass('selected') ? $(this).removeClass('selected') : $(this).addClass('selected');
		$(this).toggleClass("fa-plus-circle fa-times-circle");
	});

});
