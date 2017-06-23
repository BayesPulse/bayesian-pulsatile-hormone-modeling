###########################################################
###Program: simsummary.r
###Created by: Ken Horton and Nichole Carlson
###Created on: 3/3/11
###
###Purpose: To perform all the parameter checking and 
###         create the bias, false pos/neg calculations for
###         summarizing a set of models fitted using BDMCMC
###########################################################

####PART 1########
#This section of code creates a large pdf of plots for the common parameters. For 25 datasets, it creates a time series and histogram for
#each parameter within that dataset.


graph <- function(burnin,outputrate,commonFile,parmFile,mconFile,dataFile,graphLocation){
	

    data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "evar", "massVar","widthVar"),fill=T)
    data <- data[(burnin/outputrate):nrow(data),]


        
    pdf(file = graphLocation)
    par(mfrow=c(2,2))
    

        path <- paste(graphLocation , "/Graph1.png",sep ='')
    	png(path,width = 810, height = 550)  #change this line
    	
     
    	ts.plot(data$pulses,xlab="iteration",ylab="Number of Pulses")
    	hist(data$pulses,xlab="Number of Pulses",ylab="")

    	ts.plot(data$base,xlab="iteration",ylab="Baseline (Conc. Units)")
    	hist(data$base,ylab="",xlab="Baseline")
	

    	ts.plot(data$mpmass,xlab="iteration",ylab="Mean Pulse Mass")
    	hist(data$mpmass,ylab="",xlab="Mean Pulse Mass")

    	ts.plot(data$massVar,xlab="iteration",ylab="Pulse Mass SD")
    	hist(data$massVar,ylab="",xlab="Pulse Mass SD")

    	ts.plot(data$mpwidth,xlab="iteration",ylab="Mean Pulse Width")   
    	hist(data$mpwidth,ylab="",xlab="Mean Pulse Width")
    
     	ts.plot(data$widthVar,xlab="iteration",ylab="Pulse Width SD")
    	hist(data$widthVar,ylab="",xlab="Pulse Width SD")

        ts.plot(data$hl,xlab="iteration",ylab="Halflife (min)")
    	hist(data$hl,ylab="",xlab="Halflife (min)")
	 
    	ts.plot(data$evar,xlab="iteration",ylab="Error Var (log Conc.^2)")
    	hist(data$evar,ylab="",xlab="Error Var (log conc.^2)")

        rawdata<-read.table(dataFile,header=T)
    
        psubjdata <- read.table(parmFile,col.names= c("iter","npulse","pulsenumb","location","pmass","pwidth"),fill=T)  #subject's pulse specific parameters
	    psubjdata <- subset(psubjdata,psubjdata$iter>=burnin)

    ###call fitted data function to created fitted values###
        estconc <- read.table(mconFile,fill=T)
        estconcmean<-apply(t(estconc),1,mean)
	    estconcmedian<-apply(t(estconc),1,median)
	    estconc95l<-apply(t(estconc),1,quantile,0.025)
	    estconc95u<-apply(t(estconc),1,quantile,0.975)
        postpred<-cbind(estconcmean,estconcmedian,estconc95l,estconc95u)    
        
        ploc<-subset(psubjdata,psubjdata$location>=min(rawdata[,2]))
        ploc<-subset(ploc,ploc$location<=max(rawdata[,2]))
    
 
        nf<-layout(matrix(c(1,2),2,1,byrow=F),c(1.5,1.5),c(1.0,0.4),TRUE)   ###This is needed to make one graph with two parts####
    
        plot(rawdata[,2],rawdata[,3],
               ylab="Hormone Concentration",
               ylim=c(min(rawdata[,3],postpred[,3]),max(rawdata[,3],postpred[,4])),
               xlim=c(min(rawdata[,2]),max(rawdata[,2])),
               type="o",
               pch=20,
               col="grey55",
               axes="F",
               main="Posterior Predictive Fits")
        axis(2)
        box(lwd=2)
        lines(rawdata[,2],postpred[,1],lwd=2,col=2)
        lines(rawdata[,2],postpred[,3],lwd=1,col=1,lty=2)
        lines(rawdata[,2],postpred[,4],lwd=1,col=1,lty=2)

        hist(ploc[,4],breaks=seq(min(rawdata[,2]),max(rawdata[,2]),by=5),col=3,ylab="",xlab="Time (in min)",main="",axes=F)
        axis(1)
        box(lwd=2)
    
}    


args <- commandArgs(TRUE)
burnin <- as.double(args[1])
outputrate <- as.double(args[2])
commonFile <- args[3]
parmFile <- args[4]
mconFile <- args[5]
dataFile <- args[6]
graphLocation <- args[7]
graph(burnin,outputrate,commonFile,parmFile,mconFile,dataFile,graphLocation)
