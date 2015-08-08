library("dplyr")
testdat<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?") 
## read in data, contains col names

tbl_df(testdat)

twodays<-filter(testdat, Date == "1/2/2007" | Date == "2/2/2007") ##selects two days

fulldate = paste(twodays$Date, twodays$Time, sep=":")  ##combine Date and Time into one column
fulldateformat <-strptime(fulldate, format="%d/%m/%Y:%H:%M:%S") ##convert to POSIXlt
testdatfulldate<-cbind(fulldateformat,twodays) ##add col with time/date combined
df<-select(testdatfulldate, -Date, -Time) ##removes Date and Time columns

##PLOT 3
png(file="plot3.png", width=480, height =480) ##launch graphic device with size
with(df, plot(fulldateformat,Sub_metering_1, col="black", 
              type ="l", ylab="Energy sub metering", xlab=""))
with(df, lines(fulldateformat,Sub_metering_2, col="red"))
with(df, lines(fulldateformat,Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()









