$(function() {
  var myVarsJSON = $("#my_vars_json").html(),
      json = $.parseJSON(myVarsJSON);

  var dataPoints = [];
  var colors = ["#BF3232", "#6769E0", "#00C700", "#E0E014", "#6C048F", "#222222", "Brown"];
  var colorIndex = 0;
  for(key in json) {
	  dataPoints.push({ label: key, value: json[key], color: colors[colorIndex] });
	  colorIndex++;
  }

  var cht = document.getElementById('canvas');
  var ctx = cht.getContext('2d');
  var myDoughnutChart = new Chart($("#canvas").get(0).getContext("2d")).Doughnut(dataPoints);
});

$(function() {
	$('#notice').on('click', function() {
		$(this).fadeOut(1000);
	});
});