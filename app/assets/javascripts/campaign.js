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

	
	$(".body").each(function () {
		$(this).html(prettify($(this).text()));
	});

	$("#campaign_category_ids").chosen()
})

function prettify (text) {
	text = escapeHtml(text);

	var lines = text.split("\n");
	var rendered = "";
	var line;
	var openCode = false;

	for (var i = 0; i < lines.length; ++i) {
		line = lines[i];
		if (!lines[i] && openCode === false) { continue; }

		if (line === "~") {
			if (openCode !== false) { openCode = false; }
			else { openCode = i; }
		}

		if (openCode !== false) {
			rendered += line + "\n";
		} else {
			line = line.replace(/^((question|q)[:.,\/].*)/gi, "<strong class='question'>$1</strong>");
			line = line.replace(/^((a|answer)[:.,\/].*)/gi, "<strong class='answer'>$1</strong>");

			rendered += "<p>" + line + "</p>";
		}
	}

	rendered = rendered.replace(/(http(s)?:\/\/[^ '"\n<>\]\[\*!@\(\)]+)/g, "<a href='$1'>$1</a>");
	
	rendered = rendered.replace(/`([^`]+)`/g, "<code>$1</code>");

	rendered = rendered.replace(/\~([^\~]+)\~/g, "<code><pre>$1</pre></code>");

	rendered = rendered.replace(/\*([^\*]+)\*/g, "<em>$1</em>");

	rendered = rendered.replace(/\[<a href='([^']+)'>([^<]+)<\/a>\]/g, "<img src='$1' />");
	
	
	return rendered;
}