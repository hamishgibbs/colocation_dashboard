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

addDropdownElement = function(value, label, cls, dropdown_id){

	d3.select("#" + dropdown_id)
		.append("option")
		.attr("value", value)
		.text(label)
		.attr("class", cls)

};

/* select actual data elements here */
choices = [[1, "A"], [2, "B"], [3, "C"]]

for (choice in choices){
	addDropdownElement(choices[choice][0], choices[choice][1], "dropdown-element", "area-d")
}

$(document).ready(function() {
    $('.area-dropdown').select2();
});