DATADIR := ~/Documents/Covid-19/covid_facebook_mobility/data
RAWDIR := ${DATADIR}/Facebook_Data/Britain_Colocation
INPUTDIR := ${DATADIR}/colocation_output
PROJDIR := ~/Documents/Covid-19/colocation_dashboard
PLOTDIR := ${PROJDIR}/UK

R = /usr/local/bin/Rscript $^ $@
NODE = node $^ $@

default: push_data

update_data: ${INPUTDIR}/colocation_country_referenced.csv \
			${INPUTDIR}/colocation_gadm_names.csv

create_plot_datasets: ${PLOTDIR}/data/mean_ts.csv \
					${PLOTDIR}/data/top_n_between.csv

transform_text_files: ${PLOTDIR}/text/blurb.html \
					${PLOTDIR}/text/description.html

push_data: create_plot_datasets transform_text_files
	git add ${PLOTDIR}/data/mean_ts.csv
	git add ${PLOTDIR}/data/top_n_between.csv
	git add ${PLOTDIR}/text/blurb.html
	git add ${PLOTDIR}/text/description.html
	git commit -m "automated update"
	git push

${INPUTDIR}/colocation_country_referenced.csv: ${PROJDIR}/UK/R/assign_countries.R ${RAWDIR}
	${R}

${INPUTDIR}/colocation_gadm_names.csv: ${PROJDIR}/UK/R/assign_gadm_names.R ${INPUTDIR}/colocation_country_referenced.csv
	${R}

${PLOTDIR}/data/mean_ts.csv: ${PROJDIR}/UK/R/create_ts_data.R ${INPUTDIR}/colocation_gadm_names.csv
	${R}

${PLOTDIR}/data/top_n_between.csv: ${PROJDIR}/UK/R/create_top_n_data.R ${INPUTDIR}/colocation_gadm_names.csv
	${R}

${PLOTDIR}/text/blurb.html: ${PLOTDIR}/js/write_blurb.js
	${NODE}

${PLOTDIR}/text/description.html: ${PLOTDIR}/js/write_description.js
	${NODE}