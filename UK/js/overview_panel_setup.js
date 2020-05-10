ov_panel = function(){
	this.image_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/images/colocation_plot.png?token=AMBPN77L7MVIQHY5KOXUTVC6YBTRO"

	this.setupOvPanel = function(){

		this.container = d3.select("#panel-c")
			.append("div")
			.attr("class", "ov-container")
		
		containerDims = this.container.node().getBoundingClientRect();

		this.container
			.append("div")
			.attr("class", "area-title-container")
			.text("Facebook Colocation Data")

		this.container 
			.append("img")
				.attr("src", this.image_url)
				.attr("class", "ov-image")

		this.container.append("div")
			.attr("class", "ov-blurb")
			.text("- blurb here -")
				
	}
}
