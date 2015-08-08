library("dplyr")
testdat<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?") 
## read in data, contains col names

tbl_df(testdat)

twodays<-filter(testdat, Date == "1/2/2007" | Date == "2/2/2007") ##selects two days

fulldate = paste(twodays$Date, twodays$Time, sep=":")  ##combine Date and Time into one column
fulldateformat <-strptime(fulldate, format="%d/%m/%Y:%H:%M:%S") ##convert to POSIXlt
testdatfulldate<-cbind(fulldateformat,twodays) ##add col with time/date combined
df<-select(testdatfulldate, -Date, -Time) ##removes Date and Time columns


##PLOT 2
png(file="plot2.png", width=480, height =480) ##launch graphic device with size
plot(df$fulldateformat, df$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()