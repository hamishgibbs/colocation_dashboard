
function onlyUnique(value, index, self) { 
    return self.indexOf(value) === index;
}

addDropdownElement = function(value, label, cls, dropdown_id){

	d3.select("#" + dropdown_id)
		.append("option")
		.attr("value", value)
		.text(label)
		.attr("class", cls)

};