# colocation_dashboard
[Interactive dashboard](https://cmmid.github.io/colocation_dashboard_cmmid/) of Facebook colocation data.

js files hosted at: [https://github.com/hamishgibbs/colocation_dashboard_js](https://github.com/hamishgibbs/colocation_dashboard_js).

# Data updates
Colocation data is made available by Facebook weekly. The LSHTM colocation dashboard will be updated as soon as possible following a weekly release of colocation data.

*Please note* These datasets have been aggregated from their original format in order to be released publicly.

# Data Reference

*mean_ts.csv*
The mean colocation probability between a given area and all other areas, each week.
`connection_type`: A single value: `Between`. Specifying that the record regards data between areas, not within the same area.
`polygon1_name`: The administrative name of the "target" polygon.
`ds`: The date of the record.
`mean_colocation`: The colocation probability (see dashboard for more details).
`NAME_1`: Country name.
`GID_2`: GADM formatted area code.
`TYPE_2`: Administrative area type.
`type`: Type of record, either `perc_change` or `abs_value`. Whether the record displays unaltered mean colocation probabilites (`abs_value`), or percent change from the first timeseries point (`perc_change`). 

*top_n_between.csv*
The mean probability of colocation across the entire timeseries between selected pairs of locations. The 10 locations with the highest colocation probabilities are selected for each area. 

Fields:
`polygon1_name`: The administrative name of the "target" polygon.
`polygon2_name`: The administrative name of the "connected" polygon.
`mean_colocation`: The mean probability of colocation across the entire timeseries between `polygon1` and `polygon2`.

*name_replacement.csv*
Facebook data is referenced to administrative boundary datasets produced by Pitney Bowes. The datasets provided in this repository are referenced to publicly available [GADM](https://gadm.org/index.html) boundary datasets. In order to symbolise data using GADM boundaries, certain administrative names in the boundary input data have been altered. This file records the mapping of administrative names from Pitney Bowes polygons to GADM polygons. 

Fields:
`fb_name`: The administrative name provided by Facebook.
`replacement`: The GADM name for the same administrative area. 

Please see the website for further details about the colocation metric. 
