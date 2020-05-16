ov_panel = function(){
	this.image_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/images/colocation_plot.png?token=AMBPN77L7MVIQHY5KOXUTVC6YBTRO"
	this.image_svg_url = "https://raw.githubusercontent.com/hamishgibbs/colocation_dashboard/master/UK/images/colocation_plot.svg?token=AMBPN72Q3JPY4GHSSRTLM226YDTVE"
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

		$(".ov-blurb").html(this.blurb_text)
				
	}

	this.blurb_text = null
}

$.ajax({
    url : "text/blurb.html",
    dataType: "text",
    success : function (data) {
    	ov_panel1.blurb_text = data
        $(".ov-blurb").html(data);
    }
});