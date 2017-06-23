###########################################################
#Creates trace plots for the population level parameters
#Creates trace plots for individual level parameters as selected by the user

#Creates summary tables of population level parameters
#Creates summary tables of individual level parameters as selected by the user

#Creates fitted value plots as requested by the user

#Creates observed data plots as requested by the user
##################################################################

###################################################################################################
####FUNCTION FOR PLOTTING THE RAW DATA
#################################################################################################
rawdataplot <- function(DataFile,graphfileLocation) {
        
        path <- paste(graphfileLocation , "/rawData.png",sep ='')
        
        png(path,width = 810, height = 550)
        
        par(mfcol=c(2,2))

        rawdata<-read.table(DataFile,fill=T)
        
        for (i in 2:nrow(rawdata)) {
        plot(rawdata[,1],rawdata[,i],xlab="Time (in min)",ylab="Hormone Concentration",col=1,lwd=1.5,type="o") 
        }

}


args <- commandArgs(TRUE)
DataFile <- args[1]
graphLocation <- args[2]
rawdataplot(DataFile,graphLocation)