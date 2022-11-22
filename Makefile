export ENG_PATH := data/course_engagement.csv
export DISPLAY_CODE := FALSE
export COLOR_PALETTE := 999999 E69F00 56B4E9 009E73 F0E442 0072B2 D55E00 CC79A7

report.html: Final_Report.Rmd hsdata hstb1 hstb2 hsfig ev ar
	Rscript render_report.R
	
hsdata:
	Rscript code/hs_code/data.R
	
hstb1: 
	Rscript code/hs_code/01_make_table1.R
	
hstb2:
	Rscript code/hs_code/01_make_table2.R

hsfig:
	Rscript code/hs_code/02_make_figure.R
	
ev: 
	Rscript code/ev_code/01_watch_time.R

ar:
	Rscript code/ar_code/length_engagement.R
	
.PHONY: install 
install:
	Rscript -e "renv::restore(prompt = FALSE)"

.PHONY: clean
clean:
	rm -f Final_Report.html
	rm -f output/*.rds
	rm -f output/*.png
	rm -f data/*.rds