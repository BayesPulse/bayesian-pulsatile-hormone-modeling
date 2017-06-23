
graphHist <- function(NumberOfObservations,alpha,beta,min,max,fileLocation)
{
    path <- paste(fileLocation , "/initialConc.png",sep ='')
	png(path,  height=366, width=481 )
	initialConc <-rbeta(NumberOfObservations, alpha,beta)
    new <- (max - min) + min
    initialConc <-  new * initialConc 
	hist(initialConc)
}

args <- commandArgs(TRUE)
NumberOfObservations <- as.integer(args[1])
alpha<-  as.double(args[2])
beta<-as.double(args[3])
min <-as.double(args[4])
max <- as.double(args[5])
fileLocation<-args[6]
graphHist(NumberOfObservations,alpha,beta,min,max,fileLocation)

