description_panel = function(){
	this.fb_image_url = "https://assets.themuse.com/uploaded/companies/659/small_logo.png?v=e06509d06aae79458f7a2fe65f39bcb4cca56e964dd6d9e0390386ca1829e55a"
	this.cmmid_image_url = "https://www.lshtm.ac.uk/sites/default/files/styles/centre_header_logo/public/cmmid.jpg?itok=DVpjwx1l"
	this.lshtm_image_url = "http://pathogenseq.lshtm.ac.uk/img/lshtm-logo.jpg"

	this.fb_url = "https://dataforgood.fb.com/"
	this.cmmid_url = "https://www.lshtm.ac.uk/research/centres/centre-mathematical-modelling-infectious-diseases"
	this.lshtm_url = "https://www.lshtm.ac.uk/"

	this.setupDdPanel = function(){


		this.container = d3.select("#panel-c")
			.append("div")
			.attr("class", "area-title-container")
			.attr("id", "description-tt")
			.text("Dataset Description")

		
		this.container
			.append("div")
			.attr("class", "description-text")
			.attr("id", "description-t")
			.text("- dataset description here -")

		
		this.credits_panel = this.container
			.append("div")
			.attr("class", "credits-container")
			.attr("id", "credits-panel")

		this.credits_panel
			.append("div")
			.attr("class", "image-container")
			.append("a")
			.attr("href", this.fb_url)
			.attr("target", "_blank")
			.append("img")
			.attr("src", this.fb_image_url)
			.attr("class", "credit-image")

		this.credits_panel
			.append("div")
			.attr("class", "image-container")
			.append("a")
			.attr("href", this.lshtm_url)
			.attr("target", "_blank")
			.append("img")
			.attr("src", this.lshtm_image_url)
			.attr("class", "credit-image")

		this.credits_panel
			.append("div")
			.attr("class", "image-container")
			.append("a")
			.attr("href", this.cmmid_url)
			.attr("target", "_blank")
			.append("img")
			.attr("src", this.cmmid_image_url)
			.attr("class", "credit-image")

		this.container
			.append("div")
			.attr("class", "author-container")
			.attr("id", "author-panel")
			.text("Visualisation by Hamish Gibbs. Supported by CMMID Covid-19 Working Group, Rosalind M Eggo, and Adam Kucharski.")

	}
}
