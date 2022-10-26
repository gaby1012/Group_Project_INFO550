report.html: Final_Project.Rmd render_report.R data/course_engagement.csv code/*
	Rscript render_report.R


.PHONY: clean
clean:
	rm -f report.html