$(document).ready(function() {

  $("#search-submit").click(function() {
    let query = $("#search-query").val();
    let url = "http://localhost:8984/rest?run=entry-list.xq&$name=" + query

    $.get(url, function(data) {
      let list = $("#search-results");
      list.empty();
      $.each(data, function(index, entry) {
        list.append($("<li>")
        	.append($("<a>")
        		.attr("data-address", entry.address)
        		.addClass("entry-ref")
        		.text(entry.orth[0]))
        	.append($("<span>").text(" (" + entry.id + ")")));
      });
      $(".entry-ref").click(function(event) {
      	let content = $(event.target).data("address");
      	$("#entry-content").val(content);
      	let contentUrl = "http://localhost:8984/rest" + content;
      	$.ajax({
      		type: "GET",
      		url: contentUrl,
      		dataType: "xml",
      		success: function(xml) {
      			let serializer = new XMLSerializer();
		      	$("#entry-content").val(serializer.serializeToString(xml));
      		}
      	});
      });
    });
  });

});
