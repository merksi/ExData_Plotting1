#
#
# plot1.R
# Description: function to make plot1 for 1st course project of 
# exploratory data analysis 
# Author: Ivo Merks 

#
# 1. download data and unzip 
#
dataFilename<-"household_power_consumption.txt"
if (!file.exists(dataFilename)){
    zipFilename<-"household_power_consumption.zip"
    if (!file.exists(zipFilename)){
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url,zipfileName,mode="wb")
    }
    unzip(zipFilename,dataFilename)
}
#
# 2. read data 
# assuming that household_power_consumption.txt is in this directory 
# also assuming that computer has enough memory to read data 
#  
data<-read.csv(dataFilename,header=TRUE,sep=";")
#
# 3. select data from the dates 2007-02-01 and 2007-02-02. 
#    dates are  ambiguous. Assumming format is year-month-date
# convert to date
dataDate <- as.Date(data$Date,format="%e/%m/%Y")
# convert target dates to dates
date1<-as.Date("2007-02-01",format="%Y-%m-%e")
date2<-as.Date("2007-02-02",format="%Y-%m-%e")
# find entries of correct dates
pos=(dataDate==date1 | dataDate==date2)
# select Global Active Power data
globalActivePower<-data$Global_active_power
# select dates
globalActivePower<-globalActivePower[pos]
# convert ot numerix
globalActivePower<-as.numeric(as.character(globalActivePower))
# make graph
# once on screen, second to the graph 
for (iter in 1:2) {
    if (iter==2){
        # now make the png graph 
        png(filename="plot1.png",width=480,height=480)
    }
    hist(globalActivePower,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")
    # set ticks on x-axis
    axis(1,c(0,2,4,6))
    # set ticks on y-axis
    axis(2,c(0,200,400,600,800,1000,1200))   
    if(iter==2){
        # shut 
        dev.off()
    }
}

