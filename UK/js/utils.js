
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

refreshPanel = function(){

	d3.select("#panel-c").remove()

	d3.select(".main")
		.append("div")
		.attr("class", "main-container")
		.attr("id", "panel-c")

}

d3.selection.prototype.moveToFront = function() {  
      return this.each(function(){
        this.parentNode.appendChild(this);
      });
};

styleArea = function(area, cls){

	area_polygons = d3.selectAll(".country")._groups[0]

    for(i in area_polygons){

      if(area_polygons[i].getAttribute("polygon-name") == area){
        area_polygons[i].setAttribute("class", cls)
      }
    }

}

unstyleArea = function(cls){

	selected_area = d3.selectAll("." + cls)

  	country = selected_area.attr("country-name")

  	selected_area.attr("class", "country " + country)
}
