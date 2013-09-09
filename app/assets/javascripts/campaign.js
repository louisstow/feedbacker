$(function () {
	// show or hide the private fields
	$("#campaign_list_type_private").change(function () {
		if ($(this).is(":checked")) {
			$(".private-fields").show();
		}
	});

	$("#campaign_list_type_public").change(function () {
		if ($(this).is(":checked")) {
			$(".private-fields").hide();
		}
	});

	if ($("#campaign_list_type_private").is(":checked")) {
		$(".private-fields").show();
	} else {
		$(".private-fields").hide();	
	}
})
