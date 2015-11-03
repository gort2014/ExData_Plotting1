## plot4.R
## reads data and creates plot #4 for project 1. See followjng link for project details
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


## Display a series of four plots in one file, with 2 rows and two columns of plots 
## project instructions state we should save the plot to a .png file with width = 480, height = 480
##
##
## note: for some other problems / plots, saving to PNG ile with dev.copy() worked fine. With THIS plot,
## the only way the legend does not becme distorted in the plot is to print directly to a PNG file, bypasing the screen
## device!!!
png("C:\\andyXP\\learnings\\coursera_ds_exploratory\\project_1\\plot4.png", width=480, height=480)
par(mfrow = c(2,2))
with(mySubset, plot(Global_active_power ~ datetime, type="l", ylab = "Global Active Power"))
with(mySubset, plot(Voltage ~ datetime,type="l",xaxt="n", ylab = "Voltage"))
with(mySubset, plot(Sub_metering_1 ~ datetime,type="l",xaxt="n", ylab = "Energy sub metering", col = "black"))
with(mySubset, lines(Sub_metering_2 ~ datetime, col = "red"))
with(mySubset, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"), lty = c(1,1,1))
with(mySubset, plot(Global_reactive_power ~ datetime, type="l", xaxt="n"))
dev.off()

