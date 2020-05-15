/* add panel select buttons */

/*aCompareButtonClick = function(){

	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	refreshPanel()

	table_panel1.createTable()

}*/

tsButtonClick = function(){
	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	refreshPanel()

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

	createTsSummaryButtons("panel-c")
}


ov_panel1 = new ov_panel

ovButtonClick = function(){

	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	refreshPanel()

	ov_panel1.setupOvPanel()

}

description_panel1 = new description_panel

ddButtonClick = function(){
	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	refreshPanel()

	description_panel1.setupDdPanel()


}

acButtonClick = function(){
	d3.selectAll(".panel-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "active-button")

	refreshPanel()

	ac_panel1.setupAcPanel()

	ac_panel1.addPlotContent(ac_panel1.default_area)
}

/*in this panel - just give premade pngs */
d3.select("#panel-select-c")
	.append("div")
	.attr("class", "button-spacer")

d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ov")
		.text("Overview")
		.attr("class", "panel-button")
		.attr("id", "active-button")
		.on("click", ovButtonClick);

d3.select("#panel-select-c")
	.append("div")
	.attr("class", "button-spacer")

d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ts")
		.text("Time series")
		.attr("class", "panel-button")
		.on("click", tsButtonClick);

d3.select("#panel-select-c")
	.append("div")
	.attr("class", "button-spacer")

d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ac")
		.text("Area Comparison")
		.attr("class", "panel-button")
		.on("click", acButtonClick);

d3.select("#panel-select-c")
	.append("div")
	.attr("class", "button-spacer")

d3.select("#panel-select-c")
		.append("button")
		.attr("value", "dd")
		.text("Dataset Description")
		.attr("class", "panel-button")
		.on("click", ddButtonClick);

/*d3.select("#panel-select-c")
		.append("button")
		.attr("value", "ac")
		.text("Area comparison")
		.attr("class", "panel-button")
		.on("click", aCompareButtonClick);*/

$("#active-button").click()


/* within each button click - hold the panel setup function */

/*load data from urls and add as a window attribute */