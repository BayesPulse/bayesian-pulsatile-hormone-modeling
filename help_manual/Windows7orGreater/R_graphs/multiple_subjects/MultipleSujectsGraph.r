###########################################################
#Creates trace plots for the population level parameters
#Creates trace plots for individual level parameters as selected by the user

#Creates summary tables of population level parameters
#Creates summary tables of individual level parameters as selected by the user

#Creates fitted value plots as requested by the user

#Creates observed data plots as requested by the user
##################################################################

#This section of code creates a large pdf of plots for the common parameters. For 25 datasets, it creates a time series and histogram for
#each parameter within that dataset.

poptrace <- function(count,burnin,commonFile,graphLocation){

    ##Read in MCMC output files for population level parameters####
	data <- read.table(commonFile,col.names= c("iter","mpmass","mpwidth","popsigmaa","popsigmaw","sigmaa","sigmaw","base",  "hl", "popsigmab","popsigmahl", "evar"),fill=T)
    data <- subset(data,data$iter>=burnin)

	if(count == 1)
	{
        path <- paste(graphLocation , "/Graph1.png",sep ='')
    	png(path,width = 810, height = 550)  #change this line
    	par(mfrow=c(2,2))
    
       	ts.plot(data$mpmass[burnin:length(data[,1])],xlab="Iteration",ylab= "Pop. Mean Pulse Mass ")
    	hist(data$mpmass[burnin:length(data[,1])],xlab="Pop. Mean Pulse Mass",ylab="")

   	    ts.plot(data$popsigmaa[burnin:length(data[,1])],xlab="Iteration",ylab= "Pop. Pulse Mass SD ")
    	hist(data$popsigmaa[burnin:length(data[,1])],xlab="Pop. Pulse Mass SD",ylab="")
  
	}

	else if(count == 2)
	{
        path <- paste(graphLocation , "/Graph2.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))

    	ts.plot(data$sigmaa[burnin:length(data[,1])],xlab="Iteration",ylab= "Ind. Pulse Mass SD ")
    	hist(data$sigmaa[burnin:length(data[,1])],xlab="Ind. Pulse Mass SD",ylab="")
     
        ts.plot(data$mpwidth[burnin:length(data[,1])],xlab="Iteration",ylab="Mean Pulse Width ")   
    	hist(data$mpwidth[burnin:length(data[,1])],xlab="Mean Pulse Width",ylab="")
	}

	else if(count == 3)
	{
        path <- paste(graphLocation , "/Graph3.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))

    	ts.plot(data$popsigmaw[burnin:length(data[,1])],xlab="Iteration",ylab= "Pop. Pulse Width SD ")
    	hist(data$popsigmaw[burnin:length(data[,1])],xlab="Pop. Pulse Width SD",ylab="")

  	    ts.plot(data$sigmaw[burnin:length(data[,1])],xlab="Iteration",ylab= "Ind. Pulse Width SD ")
    	hist(data$sigmaw[burnin:length(data[,1])],xlab="Ind. Pulse Width SD",ylab="")
	}
	else if(count == 4)
	{
        path <- paste(graphLocation , "/Graph4.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))

    	ts.plot(data$base[burnin:length(data[,1])],xlab="Iteration",ylab="Baseline ")
    	hist(data$base[burnin:length(data[,1])],xlab="Baseline",ylab="")
    
    	ts.plot(data$popsigmab[burnin:length(data[,1])],xlab="Iteration",ylab="Pop. Baseline SD")
    	hist(data$popsigmab[burnin:length(data[,1])],xlab="Pop. Baseline SD",ylab="")

	}
    else if(count == 5)
    {
        path <- paste(graphLocation , "/Graph5.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))
    
        ts.plot(data$hl[burnin:length(data[,1])],xlab="Iteration",ylab="Halflife ")
    	hist(data$hl[burnin:length(data[,1])],xlab="Halflife",ylab="")
	
     	ts.plot(data$popsigmahl[burnin:length(data[,1])],xlab="Iteration",ylab="Pop. Halflife SD")
    	hist(data$popsigmahl[burnin:length(data[,1])],xlab="Pop. Halflife SD",ylab="")
    }
    else if(count == 6)
    {
    	path <- paste(graphLocation , "/Graph6.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))
    
        ts.plot(data$evar[burnin:length(data[,1])],xlab="Iteration",ylab="Error Variance")
    	hist(data$evar[burnin:length(data[,1])],xlab="Error Variance",ylab="")
    }
}    


args <- commandArgs(TRUE)
iterator <- as.integer(args[1])
burnin <- as.double(args[2])
commonFile <- args[3]
graphLocation <- args[4]
poptrace(iterator,burnin,commonFile,graphLocation)