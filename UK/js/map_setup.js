/* keep all css definitions in the css file */
d3.select("#map-c")
	.append("svg")
	.attr("class", "main-map")
	.attr("id", "main-m");


/* add dropdown selection with scroll and search (from select2) */
d3.select("#map-c")
	.append("div")
	.attr("class", "dropdown-container");

d3.select("#dropdown-c")
	.append("select")
	.attr("class", "area-dropdown")
	.attr("id", "area-d");

$(document).ready(function() {
    $('.area-dropdown').select2();
});

$('select').on('change', function() {

    area_name = this.value

	ts_plot1.removePlotContent()

	ts_plot1.addPlotContent(area_name)

	ts_plot2.addPlotContent(area_name)

	d3.select("#area-title-c")
		.text(area_name)

	ac_panel1.removePlotContent(area_name)

	ac_panel1.addPlotContent(area_name)

});

