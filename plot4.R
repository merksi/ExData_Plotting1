#
#
# plot4.R
# Description: function to make plot4 for 1st course project of 
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
# select Voltage data
voltage<-dataPos$Voltage
# convert to numeric
voltage<-as.numeric(as.character(voltage))
# select Global Reactive Power data
globalReactivePower<-dataPos$Global_reactive_power
# convert to numeric
globalReactivePower<-as.numeric(as.character(globalReactivePower))
# select sub metering data
subMetering1<-dataPos$Sub_metering_1
subMetering2<-dataPos$Sub_metering_2
subMetering3<-dataPos$Sub_metering_3
# convert to numeric
subMetering1<-as.numeric(as.character(subMetering1))
subMetering2<-as.numeric(as.character(subMetering2))
subMetering3<-as.numeric(as.character(subMetering3))
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
        png(filename="plot4.png",width=480,height=480)
    }
    # make 4 subplots 
    par(mfrow = c(2, 2))
    # plot data - top left
    plot(relDateTimeStampN,globalActivePower,xaxt="n",col="black",pch=".",type="l",xlab="",ylab="Global Active Power",main="")
    # set ticks on x-axis
    axis(1,at=c(0,1,2),labels=c("Thu","Fri","Sat"))        
    # set ticks on y-axis
    axis(2,c(0,2,4,6))            
    # plot data - top right
    plot(relDateTimeStampN,voltage,xaxt="n",col="black",pch=".",type="l",xlab="datetime",ylab="Voltage",main="")
    # set ticks on x-axis
    axis(1,at=c(0,1,2),labels=c("Thu","Fri","Sat"))        
    # set ticks on y-axis
    axis(2,c(234,238,242,246))                
    # plot data - bottom left
    plot(relDateTimeStampN,subMetering1,xaxt="n",col="black",pch=".",type="l",xlab="",ylab="Energy sub metering",main="")
    lines(relDateTimeStampN,subMetering2,col="red")
    lines(relDateTimeStampN,subMetering3,col="blue")     
    # set ticks on x-axis
    axis(1,at=c(0,1,2),labels=c("Thu","Fri","Sat"))        
    # set ticks on y-axis
    axis(2,c(0,10,20,30))        
    # add legend 
    legend("topright", lty=c(1,1,1), col = c("black", "red","blue"),bty="n",legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
    # plot data - bottom right
    plot(relDateTimeStampN,globalReactivePower,xaxt="n",col="black",pch=".",type="l",xlab="datetime",ylab="Global_Reactive_power",main="")
    # set ticks on x-axis
    axis(1,at=c(0,1,2),labels=c("Thu","Fri","Sat"))        
    # set ticks on y-axis
    axis(2,c(0.0,0.1,0.2,0.3,0.4,0.5))                    
    # shut off graph 
    if(iter==2){
        # shut 
        dev.off()
    }
}
