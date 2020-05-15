DATADIR := ~/Documents/Covid-19/covid_facebook_mobility/data
RAWDIR := ${DATADIR}/Facebook_Data/Britain_Colocation
INPUTDIR := ${DATADIR}/colocation_output
PROJDIR := ~/Documents/Covid-19/colocation_dashboard
PLOTDIR := ${PROJDIR}/UK/data

R = /usr/local/bin/Rscript $^ $@

default: update_data create_plot_datasets

update_data: ${INPUTDIR}/colocation_country_referenced.csv \
			${INPUTDIR}/colocation_gadm_names.csv

create_plot_datasets: ${PLOTDIR}/mean_ts.csv \
					${PLOTDIR}/top_n_between.csv

${INPUTDIR}/colocation_country_referenced.csv: ${PROJDIR}/UK/R/assign_countries.R ${RAWDIR}
	${R}

${INPUTDIR}/colocation_gadm_names.csv: ${PROJDIR}/UK/R/assign_gadm_names.R ${INPUTDIR}/colocation_country_referenced.csv
	${R}

${PLOTDIR}/mean_ts.csv: ${PROJDIR}/UK/R/create_ts_data.R ${INPUTDIR}/colocation_gadm_names.csv
	${R}

${PLOTDIR}/top_n_between.csv: ${PROJDIR}/UK/R/create_top_n_data.R ${INPUTDIR}/colocation_gadm_names.csv
	${R}

