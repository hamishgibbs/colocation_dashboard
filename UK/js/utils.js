
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