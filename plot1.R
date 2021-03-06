library("dplyr")
testdat<-read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?") 
## read in data, contains col names

tbl_df(testdat)

twodays<-filter(testdat, Date == "1/2/2007" | Date == "2/2/2007") ##selects two days

fulldate = paste(twodays$Date, twodays$Time, sep=":")  ##combine Date and Time into one column
fulldateformat <-strptime(fulldate, format="%d/%m/%Y:%H:%M:%S") ##convert to POSIXlt
testdatfulldate<-cbind(fulldateformat,twodays) ##add col with time/date combined
df<-select(testdatfulldate, -Date, -Time) ##removes Date and Time columns


##PLOT 1
png(file="plot1.png", width=480, height =480) ##launch graphic device with size
hist(df$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
## plots histogram

dev.off()


