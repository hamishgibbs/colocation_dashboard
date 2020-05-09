/* add panel select buttons */

panelButtonClick = function(){

	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	/* if value = ts, setup ts panel */

}

tsButtonClick = function(){
	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	d3.select("#panel-c").remove()

	d3.select(".main")
		.append("div")
		.attr("class", "panel-container")
		.attr("id", "panel-c")

	d3.select("#panel-c")
		.append("div")
		.attr("class", "area-title-container")
		.attr("id", "area-title-c")


	ts_plot1.appendSVG('panel-c', 'ts1-c', 'ts-container', 'ts1', 'ts-plot')

	ts_plot2.appendSVG('panel-c', 'ts2-c', 'ts-container', 'ts2', 'ts-plot')

	ts_plot1.layoutPlot()
	ts_plot2.layoutPlot()

	d3.select("#area-title-c")
		.text(ts_plot1.default_area)

}

ovButtonClick = function(){

	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	d3.select("#panel-c").remove()

	
}

/*in this panel - just give premade pngs */
d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ov")
		.text("Overview")
		.attr("class", "panel-button")
		.on("click", ovButtonClick);


d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ts")
		.text("Time series")
		.attr("class", "panel-button")
		.attr("id", "active-button")
		.on("click", tsButtonClick);

d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ac")
		.text("Area comparison")
		.attr("class", "panel-button")
		.on("click", panelButtonClick);




/* within each button click - hold the panel setup function */

/*load data from urls and add as a window attribute */