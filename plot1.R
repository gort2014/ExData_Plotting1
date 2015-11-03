## plot1.R
## reads data and creates plot #1 for project 1. See followjng link for project details
## https://class.coursera.org/exdata-033/human_grading/view/courses/975128/assessments/3/submissions

## read in data. Treat "?" character as NA
myFile <- read.table("C:\\andyXP\\learnings\\coursera_ds_exploratory\\project_1\\household_power_consumption.txt",
                     colClasses = c(rep("character",2),rep("numeric",7)),sep=";",na.strings = "?",header = TRUE)

## instructions state we should isolate data with dates 2007-02-01 and 2007-02-02

# first isolate dates Feb-1-2007 and Feb-2-2-7
# get logical vector to subset dataframe by date
myRowSubset <- as.Date(myFile$Date,format = "%d/%m/%Y") == as.Date("2007-02-01",format = "%Y-%m-%d") | 
        as.Date(myFile$Date, format = "%d/%m/%Y") == as.Date("2007-02-02",format = "%Y-%m-%d")
sum(myRowSubset,na.rm = TRUE)

## subset dataframe
mySubset <- myFile[myRowSubset,]
head(mySubset)
tail(mySubset)
unique(weekdays(as.Date(mySubset[,1],format = "%d/%m/%Y")))

## concatenate column #1 (date) and column #2 (time) to create a POSIXct and store in new column called 'datetime'
# make sure to use format with capital "Y" because input data string has century, i.e. "2006" inetad of "06"
mySubset$datetime<-as.POSIXct(strptime(paste(mySubset[,1], mySubset[,2], sep = " "),format = "%d/%m/%Y %H:%M"))
head(mySubset)

## get histogram with specied colors and labels. Use with()  to save typing
par(mfrow = c(1,1))
with(mySubset, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")) 
     
     
## project instructions state we should save the plot to a .png file with width = 480, height = 480
dev.copy(png, file = "C:\\andyXP\\learnings\\coursera_ds_exploratory\\project_1\\plot1.png",width = 480, height = 480)
dev.off()

