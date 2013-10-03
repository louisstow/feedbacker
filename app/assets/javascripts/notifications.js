$(function () {
	$(".notification-count").click(function () {
		var val = parseInt($(this).text(), 10);
		
		if (val) {
			$(".notifications").toggle();
			$(".notifications li").each(linkNotification);

			$.ajax({
				method: "POST",
				url: "/notifications/clear"
			});
		}
	});
});

function linkNotification () {
	$(this).find("span").click(function () {
		var id = $(this).attr("data-id");
		var hash = "";
		
		if (id.indexOf('#') !== -1) {
			var ids = id.split('#');
			id = ids[0];
			hash = "#feedback" + ids[1];
		}

		window.location = "/campaigns/" + id + hash;
	});
}