
graphHist <- function(NumberOfObservations,meanOfPriorForBase, varianceOfPrior,filename)
{
	png(filename, height=366, width=481)
	baseline <-rnorm(NumberOfObservations,meanOfPriorForBase, sqrt(varianceOfPrior))
	hist(baseline)
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForBase <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
filename <- args[4]
graphHist(NumberOfObservations, meanOfPriorForBase, varianceOfPrior,filename )


