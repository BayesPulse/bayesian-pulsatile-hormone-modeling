
graphHist <- function(NumberOfObservations ,meanOfPriorForMPW, varianceOfPrior,fileLocation,label)
{
	png(fileLocation, height=366, width=481)
	graph_of_prior_mean_pulse_width <-rnorm(NumberOfObservations,meanOfPriorForMPW, sqrt(meanOfPriorForMPW))
	graph_of_prior_mean_pulse_width <- graph_of_prior_mean_pulse_width[graph_of_prior_mean_pulse_width > 0]
	hist(graph_of_prior_mean_pulse_width,main = label )
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
meanOfPriorForMPW <-  as.double(args[2])
varianceOfPrior <-  as.double(args[3])
fileLocation <- args[4]
label <- args[5]
graphHist(NumberOfObservations, meanOfPriorForMPW, varianceOfPrior,fileLocation,label)

