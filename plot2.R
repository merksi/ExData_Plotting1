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
        download.file(url,zipFilename,mode="wb")
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
# select data of certain dates
dataPos<-data[pos,]
# select Global Active Power data
globalActivePower<-dataPos$Global_active_power
# convert to numeric
globalActivePower<-as.numeric(as.character(globalActivePower))
# select date and timestamp and put them together in one character array 
dateTimeStampStr<-paste(as.character(dataPos$Date),as.character(dataPos$Time))
# convert them to one time stamp
dateTimeStamp<-strptime(dateTimeStampStr, "%d/%m/%Y %H:%M:%S")
# calculate difference relative to first timestamp in days
relDateTimeStamp<- difftime(dateTimeStamp[1:length(dateTimeStamp)],dateTimeStamp[1],unit="days")
# convert to numeric
relDateTimeStampN<-as.numeric(relDateTimeStamp)
# make graph
# once on screen, second to the graph 
for (iter in 1:2) {
    if (iter==2){
        # now make the png graph 
        png(filename="plot2.png",width=480,height=480)
    }
    # plot data
    plot(relDateTimeStampN,globalActivePower,xaxt="n",col="black",pch=".",type="o",xlab="",ylab="Global Active Power (kilowatts)",main="")
    # set ticks on x-axis
    axis(1,at=c(0,1,2),labels=c("Thu","Fri","Sat"))        
    # set ticks on y-axis
    axis(2,c(0,2,4,6))        
    # shut off graph 
    if(iter==2){
        # shut 
        dev.off()
    }
}
