report.html: Final_Report.Rmd hstb1 hstb2 hsfig ev
	Rscript render_report.R
	
hstb1: code/hs_code/data.R
	Rscript code/hs_code/01_make_table1.R
	
hstb2:
	Rscript code/hs_code/01_make_table2.R

hsfig:
	Rscript code/hs_code/02_make_figure.R
	
ev: 
	Rscript code/ev_code/01_watch_time.R
	
.PHONY: clean
clean:
	rm -f Final_Report.html
	rm -f output/*.rds
	rm -f output/*.png