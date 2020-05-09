/* add panel select buttons */

addButton = function(value, label, cls, div_id){

	d3.select("#" + div_id)
		.append("button")
		.attr("value", value)
		.text(label)
		.attr("class", cls)

};

addButton("ts", "Time series", "panel-button", "panel-select-c")

addButton("ac", "Area comparison", "panel-button", "panel-select-c")