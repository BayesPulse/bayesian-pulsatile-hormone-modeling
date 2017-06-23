
graphHist <- function(NumberOfObservations,vectorOfRates,fileLocation)
{
    path <- paste(fileLocation , "/halflife.png",sep ='')
	png(path, height=366, width=481)
	HalfLife <-rexp(NumberOfObservations, vectorOfRates)
	hist(HalfLife)
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
vectorOfRates<-  as.double(args[2])
fileLocation <- args[3]
graphHist(NumberOfObservations,vectorOfRates,fileLocation)

