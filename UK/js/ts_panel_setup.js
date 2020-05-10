addDropdownElement

ts_data_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/data/mean_ts.csv?token=AMBPN75YWOFQOKKCQ6GJIB26X6JJE"

var parseTime = d3.timeParse("%Y-%m-%d");

ts_plot = function(){
	this.data = null;

	this.area_names = null;

	this.y_label = null;

	this.dataset_type = null;

	this.default_area = "Aberdeen";

	this.margin = {top: 0, right: 30, bottom: 50, left: 70}

	this.printData = function(){console.log(this.data)};

	this.appendSVG = function(panel_id, container_id, container_cls, svg_id, svg_cls){

		this.panel = d3.select("#" + panel_id)
		this.container = d3.select("#" + container_id)

		d3.select("#" + panel_id)
			.append('div')
			.attr("id", container_id)
			.attr("class", container_cls)

		this.svg = d3.select('#' + container_id)
			.append('svg')
			.attr("id", svg_id)
			.attr("class", svg_cls)
			.append("g")
    		.attr("transform",
          "translate(" + this.margin.left + "," + this.margin.top + ")");
			
	};

	this.defineAxes = function(container_id, data){

		var containerDims = d3.select("#" + container_id).node().getBoundingClientRect();
		
		this.width = containerDims.width - this.margin.left - this.margin.right;
		this.height = containerDims.height - this.margin.top - this.margin.bottom;

		this.x = d3.scaleTime().range([0, this.width]);
		this.y = d3.scaleLinear().range([this.height, 0]);

		this.x.domain(d3.extent(data, function(d) { return d.ds; }));
  		this.y.domain([0, d3.max(data, function(d) { return d.mean_colocation; })]);
  		
  		console.log(d3.max(data, function(d) { return d.mean_colocation; }))

  		var x = this.x
  		var y = this.y

  		/*namespace issue - not this */ 
  		this.plotLine = d3.line()
    					.x(function(d) { return x(d.ds); })
    					.y(function(d) { return y(d.mean_colocation); });
	};

	this.layoutPlot = function(){

		this.svg
			.append("g")
			.attr("transform", "translate(0," + this.height + ")")
			.call(d3.axisBottom(this.x));

		this.svg
			.append("g")
      		.call(d3.axisLeft(this.y));

      	this.svg
	    	.append("text")
	        .attr("transform", "rotate(-90)")
	        .attr("y", 0 - this.margin.left)
	        .attr("x",0 - (this.height / 2))
	        .attr("dy", "1em")
	        .style("text-anchor", "middle")
	        .text(this.y_label);

	    this.addPlotContent(this.default_area)

	    this.tooltip_div = this.container.append("div")	
    		.attr("class", "tooltip")				
    		.style("opacity", 0);
	      
	};

    this.addPlotContent = function(area){
    	
    	if (['England', 'Wales', 'Scotland', 'Northern Ireland'].includes(area)){
    		plot_data = this.data.filter(function(d){ return d.NAME_1 == area;})

    		area_names = plot_data.map(function(d){ return d.polygon1_name }).filter( onlyUnique )

    		for(i in area_names){
    			area_data = plot_data.filter(function(d){ return d.polygon1_name == area_names[i];})

    			this.svg
	    		.append("path")
	      		.data([area_data])
	      		.attr("class", "ts-plot-content summary" + " " + this.dataset_type)
	      		.attr("d", this.plotLine)
	      		.attr("value", area_names[i])
	      		.on("mouseover", this.changeTitle)
	      		.on("mouseout", this.resetTitle);

    		}

    	}else{
    		plot_data = this.data.filter(function(d){ return d.polygon1_name == area;})

    		this.svg
	    		.append("path")
	      		.data([plot_data])
	      		.attr("class", "ts-plot-content" + " " + this.dataset_type)
	      		.attr("d", this.plotLine);

    	}
    	
    	console.log(plot_data)
    	/* line not appearing correctly here - style issue?*/ 

    };

    this.changeTitle = function(){

    	d3.select("#area-title-c")
			.text(d3.select(this).attr("value"))

	}

	this.resetTitle = function(){
		console.log(d3.select("#summary-button-active").text())
    	d3.select("#area-title-c")
			.text(d3.select("#summary-button-active").text())

	}


    this.removePlotContent = function(){
    	d3.selectAll('.ts-plot-content').remove()
    }

}


/*add div to hold title */
createTsSummaryButtons = function(panel_id){
		d3.select("#" + panel_id)
			.append("button")
			.attr("value", "England")
			.text("England")
			.attr("class", "summary-button")
			.on("click", summaryButtonClick)

		d3.select("#" + panel_id)
			.append("button")
			.attr("value", "Wales")
			.text("Wales")
			.attr("class", "summary-button")
			.on("click", summaryButtonClick)

		d3.select("#" + panel_id)
			.append("button")
			.attr("value", "Scotland")
			.text("Scotland")
			.attr("class", "summary-button")
			.on("click", summaryButtonClick)

		d3.select("#" + panel_id)
			.append("button")
			.attr("value", "Northern Ireland")
			.text("Northern Ireland")
			.attr("class", "summary-button")
			.on("click", summaryButtonClick)
}

summaryButtonClick = function(){

	d3.selectAll("#summary-button")
		.attr("id", null)

	d3.select(this)
		.attr("id", "summary-button-active")

	ts_plot1.removePlotContent()

	ts_plot2.removePlotContent()

	ts_plot1.addPlotContent(this.value)

	ts_plot2.addPlotContent(this.value)

	d3.select("#area-title-c")
		.text(this.value)
}


var ts_plot1 = new ts_plot()

ts_plot1.y_label = "Probabilty of colocation outside home area"

ts_plot1.appendSVG('panel-c', 'ts1-c', 'ts-container', 'ts1', 'ts-plot')

var ts_plot2 = new ts_plot()

ts_plot2.y_label = "Probabilty of colocation within home area"

ts_plot2.appendSVG('panel-c', 'ts2-c', 'ts-container', 'ts2', 'ts-plot')

ts_plot1.dataset_type = 'between'

ts_plot2.dataset_type = 'within'

/* remember to parse up here */
Promise.all([d3.csv(ts_data_url, d3.autoType)]).then(function(data){
	
	data = data[0]
	/*parsing issue */
	area_names = data.map(function(d){ return d.polygon1_name }).filter( onlyUnique )

	ts_plot1.area_names = area_names

	for (i in area_names){
		addDropdownElement(area_names[i], area_names[i], "dropdown-element", "area-d")
	}

	within_data = data.filter(function(d){ return d.type == 'Within';})
	console.log(within_data)
	/* threshold within data so that it is < 0.025 (remove outliers) */
	within_data = within_data.filter(function(d){ return d.mean_colocation < 0.025;})

	console.log(within_data)

	between_data = data.filter(function(d){ return d.type == 'Between';})
	


	/* divide data within and between */
	ts_plot1.data = between_data
	ts_plot2.data = within_data


	ts_plot1.defineAxes('ts1-c', between_data)

	ts_plot2.defineAxes('ts2-c', within_data)

	d3.select("#area-title-c")
		.text(ts_plot1.default_area)
})

/* add buttons for country summaries */






