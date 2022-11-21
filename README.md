# ENGAGEMENT REPORT - Gaby, Anyue, Eric, Huiqing 
This code will produce our report on class engagement. 

# Contents
## Code
The code folder contains subfolders with code from each of the Coders. 
  
## Data 
The data folder contains course_engagement.csv - the assigned dataset. 

## Final_Project.Rmd
This is the final R-markdown, it will use all the code in the code foldesr to build the final report.

## render_report.R
This is an R-script to render the Project.Rmd file.

## Makefile 
This makefile sets the rules for making the final report.

# TO RUN
To run, all you wil need to do is run 'make' while in the Project Folder. 

## Customization - Dataset
You have the option to specific a new dataset to run the report on. The only constraint is that it must be contained in the project folder. To specify a dataset other than the default, run  make ENG_PATH={pathname}. 

## Customization - Display
You have the option to specify whether or not the code chunks display in the final report. The default is FALSE but switch to true with make DISPLAY_CODE=TRUE.

## Customization - Color Palette
You can also specify the color palette used in the main bar graph. The default is the colorblind palette but you can change it by using  make COLOR_PALETTE={palette} and send the color palette in form (num num num num). Exclude the #s from the list). 