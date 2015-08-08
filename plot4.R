library("dplyr")
testdat<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?") 
## read in data, contains col names

tbl_df(testdat)

twodays<-filter(testdat, Date == "1/2/2007" | Date == "2/2/2007") ##selects two days

fulldate = paste(twodays$Date, twodays$Time, sep=":")  ##combine Date and Time into one column
fulldateformat <-strptime(fulldate, format="%d/%m/%Y:%H:%M:%S") ##convert to POSIXlt
testdatfulldate<-cbind(fulldateformat,twodays) ##add col with time/date combined
df<-select(testdatfulldate, -Date, -Time) ##removes Date and Time columns

png(file="plot4.png", width=480, height =480) ##launch graphic device with size

par(mfrow = c(2,2), mar = c(5,4,1,1), oma = c(0,0,0,0))

##plot 1
plot(df$fulldateformat, df$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="")

##plot2
plot(df$fulldateformat, df$Voltage, type="l", xlab="datetime", ylab="Voltage")

##plot3
with(df, plot(fulldateformat,Sub_metering_1, col="black", 
              type ="l", ylab="Energy sub metering", xlab=""))
with(df, lines(fulldateformat,Sub_metering_2, col="red"))
with(df, lines(fulldateformat,Sub_metering_3, col="blue"))
legend("topright", bty= "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black", "red", "blue"))

##plot 4
plot(df$fulldateformat, df$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")


dev.off()







