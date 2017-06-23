###########################################################################
#Filename:  SummaryBDMCMCSingleSubjects.r
#
#Created by: Nichole Carlson
#
#Purpose:  To created the output graphs for the single subject model
#
#
########################################################################

graph <- function(count,burnin,outputrate,commonFile,parmFile,mconFile,dataFile,graphLocation){
	

	data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "evar", "massVar","widthVar"),fill=T)
    data <- data[(burnin/outputrate):nrow(data),]



    if(count == 1){
        path <- paste(graphLocation , "/Graph1.png",sep ='')
    	png(path,width = 810, height = 550)  #change this line
    	par(mfrow=c(2,2))
     
    	ts.plot(data$pulses,xlab="iteration",ylab="Number of Pulses")
    	hist(data$pulses,xlab="Number of Pulses",ylab="")

    	ts.plot(data$base,xlab="iteration",ylab="Baseline (Conc. Units)")
    	hist(data$base,ylab="",xlab="Baseline")
	
    }
    else if (count == 2) {
        path <- paste(graphLocation , "/Graph2.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))

    	ts.plot(data$mpmass,xlab="iteration",ylab="Mean Pulse Mass")
    	hist(data$mpmass,ylab="",xlab="Mean Pulse Mass")

    	ts.plot(data$massVar,xlab="iteration",ylab="Pulse Mass SD")
    	hist(data$massVar,ylab="",xlab="Pulse Mass SD")

    }
    else if (count == 3) {
        path <- paste(graphLocation , "/Graph3.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))
        

    	ts.plot(data$mpwidth,xlab="iteration",ylab="Mean Pulse Width")   
    	hist(data$mpwidth,ylab="",xlab="Mean Pulse Width")
    
     	ts.plot(data$widthVar,xlab="iteration",ylab="Pulse Width SD")
    	hist(data$widthVar,ylab="",xlab="Pulse Width SD")
     }
     
    else if (count == 4) {

        path <- paste(graphLocation , "/Graph4.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))

        ts.plot(data$hl,xlab="iteration",ylab="Halflife (min)")
    	hist(data$hl,ylab="",xlab="Halflife (min)")
	 
    	ts.plot(data$evar,xlab="iteration",ylab="Error Var (log Conc.^2)")
    	hist(data$evar,ylab="",xlab="Error Var (log conc.^2)")

    }
    else if (count == 5) {
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
    
   
    
        path <- paste(graphLocation , "/Graph5.png",sep ='')
    	png(path,width = 810, height = 550)   ####THIS MIGHT NEED CHANGING.  THIS SHOULD BE ONE LARGE GRAPH, NOT 4 SMALL ONES
 
        nf<-layout(matrix(c(1,2),2,1,byrow=F),c(1.5,1.5),c(1.0,0.4),TRUE)   ###This is needed to make one graph with two parts####
    
        par(mar=c(0,4,2,0))
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
    
        par(mar=c(4,4,0,0))
        hist(ploc[,4],breaks=seq(min(rawdata[,2]),max(rawdata[,2]),by=5),col=3,ylab="",xlab="Time (in min)",main="",axes=F)
        axis(1)
        box(lwd=2)
    }

}    


args <- commandArgs(TRUE)
iterator <- as.integer(args[1])
burnin <- as.double(args[2])
outputrate <- as.double(args[3])
commonFile <- args[4]
parmFile <- args[5]
mconFile <- args[6]
dataFile <- args[7]
graphLocation <- args[8]
graph(iterator,burnin,outputrate,commonFile,parmFile,mconFile,dataFile,graphLocation)


    
