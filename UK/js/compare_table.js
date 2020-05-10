table_panel = function(){
	this.data = null;

	this.data_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/data/top_10_between.csv?token=AMBPN7ZDWA3POX6HUHNOFWS6YBXZU"
	
	this.default_area = "Aberdeen";

	this.createTable = function(){
		this.container = d3.select("#panel-c")

		this.table = this.container
			.append("table")
			.attr("class", "compare-table")
			.attr("id", "compare-t")

		this.table_header = this.table.append("thead").append("tr");

		this.columns = ["Mean Colocation", "Home Area", "Other Area"]

		this.table_header
			.selectAll("th")
            .data(this.columns)
            .enter()
            .append("th")
            .text(function(d) { return d; });

		this.populateTable(this.default_area)
	}

	this.populateTable = function(area){

		var table_data = this.data.filter(function(d){ return d.polygon1_name == area;})
		console.log(table_data)

		var table = $('<table>').addClass('foo');
		for(i=0; i<table_data.length; i++){
		    var row = $('<tr>').addClass('bar').text('result ' + i);
		    table.append(row);
		}

		$('#panel-c').append(table);

	}
}

var table_panel1 = new table_panel


Promise.all([d3.csv(table_panel1.data_url, d3.autoType)]).then(function(data){
	table_panel1.data = data[0]
})