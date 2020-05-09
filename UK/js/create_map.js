/* reduce the size of the map data */
geodata_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/geodata/UK_simple.geojson?token=AMBPN7YM2VWD5RVOGNE5GHS6X6I3E"

map_svg = d3.select("#main-m")

map_svg_dims = document.getElementById('main-m').getBoundingClientRect()

/* add auto scale */
var projection = d3.geoMercator()
					.translate([map_svg_dims.width/2, map_svg_dims.height/2])
					.scale(2200)
					.center([-3, 53]);

var path = d3.geoPath().projection(projection);

Promise.all([d3.json(geodata_url)]).then(function(data){
	data = data[0]
	
	country_class = data.features.map(function(d) { return "country " + d.properties.NAME_1; })


    map_svg.append("g")
      .attr("class", "areas")
    	.selectAll("path")
    	.data(data.features)
    	.enter().append("path")
	      .attr("d", path)
	      .attr("fill", "lightgray")
      	.attr("stroke", "white")
      	.attr("class", mapCountryClass)
      	.attr("polygon-name", function(d){ return d.properties.NAME_2; })
      	.on("click", mainMapClick)

    
});

mapCountryClass = function(d){

	if (ts_plot1.area_names.includes(d.properties.NAME_2)){

		return "country " + d.properties.NAME_1;

	}else{

		return "country " + "no-data";

	}
}

mainMapClick = function(){
		
	area_name = d3.select(this).attr("polygon-name")

	ts_plot1.removePlotContent()

	ts_plot1.addPlotContent(area_name)

	ts_plot2.addPlotContent(area_name)

	d3.select("#area-title-c")
		.text(area_name)

}