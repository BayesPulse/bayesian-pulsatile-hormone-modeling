###########################################################
#Creates trace plots for the population level parameters
#Creates trace plots for individual level parameters as selected by the user

#Creates summary tables of population level parameters
#Creates summary tables of individual level parameters as selected by the user

#Creates fitted value plots as requested by the user

#Creates observed data plots as requested by the user
##################################################################



#########################################################################################
###Code for plotting subject level information
###Function: User selects a subject to make graphs of.
###We have to create the fitted values.  There are three subroutines needed:
###1) erf
###2) meani: this function calculates the fitted value for each pulse at one iteration
###3) postpredcalc<-function(burnin,obs,sdata,pdata,errorest,subjid,outFile): this function calculates the mean, median
###             and 2.5 and 95% quantiles of fitted values at each time point
#################################################################################

    erf<-function(x){
    
  

	y<-2*pnorm(x*sqrt(2),0,1)-1
	y
	}

###Function:  meani--the expected hormone concentration at time t for pulse i
### t is the time in minutes
### b is the baseline in concentration units
### a is the pulse mass for pulse "i"
### tau1 is the pulse location in minutes for pulse "i"
### lam is the decay rate in minutes
### s2p is the pulse variance for pulse "i" in minutes squared
meani<-function(t,b,a,tau1,lam,s2p){
	m<-b+(a/2)*pmin(exp((tau1-t)*lam + 0.5*lam^2*s2p),10^100)*(1+erf((t-(tau1+lam*s2p))/sqrt(2*s2p)))
	m
	}



###Function:  postpredcalc--calculates the median, mean and quantiles of the posterior predictive distribution for a single subject
postpredcalc<-function(burnin,obs,sdata,pdata,errorest,subjid,outFile){
    stor.numb<-diff(sdata$iter)[1]

    ##set times of observaton    
	taxis<-obs[,1]	

	#ith subject's observed values
	obs<-obs[,subjid+1]
	
	#Using estimates of subject and pulse specific parameters, find estimated
	#concentration at each iteration. 
	
	#Create matrix to store estimated concentrations
	estconc<-matrix(0,nrow(sdata),length(taxis))

   
     
	for(t in 1:nrow(sdata)){
		#For iteration t, get pulse specific estimates
		pdatat<-pdata[pdata$iter==(burnin+stor.numb*(t-1)),]
        
		#Use this info to get estimated concentration
		temp<-rep(0,length(taxis))
		for(k in 1:(max(pdatat[,3]+1))){
			temp<-temp+meani(taxis,0,pdatat[k,4],pdatat[k,6],log(2)/sdata[t,6],pdatat[k,5])
			}
		estconc[t,]<-temp+sdata[t,5]+rnorm(length(taxis),0,sqrt(errorest$evar[t]))
		}

	estconcmean<-apply(t(estconc),1,mean)
	estconcmedian<-apply(t(estconc),1,median)
	estconc95l<-apply(t(estconc),1,quantile,0.025)
	estconc95u<-apply(t(estconc),1,quantile,0.975)
    postpred<-cbind(estconcmean,estconcmedian,estconc95l,estconc95u)
    
    ####print out the values for plotting in another program
    write("mean      median      CI95L      CI95U",file=outFile)
    write(t(postpred),ncol=4,file=outFile,append=T)
}	



  
subjgraphs <- function(count,burnin,DataFile,subjFile,ParmFile,commonFile,subjid,graphLocation) {

    ##Read in MCMC output files for population level parameters####
	subjdata <- read.table(subjFile,col.names= c("iter","npulse","mpmass","mpwidth","base","hl"),fill=T)
    subjdata <- subset(subjdata,subjdata$iter>=burnin)
	if(count == 1)
	{
        path <- paste(graphLocation , "/Graph1.png",sep ='')
    	png(path,width = 810, height = 550)  #change this line
    	par(mfrow=c(2,2))

      	 ts.plot(subjdata$npulse[burnin:length(subjdata[,1])],xlab="Iteration",ylab= "Number of Pulses",main=paste("Subject",sep=" ",subjid))
    	hist(subjdata$npulse[burnin:length(subjdata[,1])],xlab="Number of Pulses",ylab="",main=paste("Subject",sep=" ",subjid))

  	    ts.plot(subjdata$mpmass[burnin:length(subjdata[,1])],xlab="Iteration",ylab= "Pop. Mean Pulse Mass ",main=paste("Subject",sep=" ",subjid))
    	hist(subjdata$mpmass[burnin:length(subjdata[,1])],xlab="Pop. Mean Pulse Mass",ylab="",main=paste("Subject",sep=" ",subjid))
    }
    else if(count == 2)
	{
        path <- paste(graphLocation , "/Graph2.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))
    
        ts.plot(subjdata$mpwidth[burnin:length(subjdata[,1])],xlab="Iteration",ylab="Mean Pulse Width ",main=paste("Subject",sep=" ",subjid))   
    	hist(subjdata$mpwidth[burnin:length(subjdata[,1])],xlab="Mean Pulse Width",ylab="",main=paste("Subject",sep=" ",subjid))

    	ts.plot(subjdata$base[burnin:length(subjdata[,1])],xlab="Iteration",ylab="Baseline ",main=paste("Subject",sep=" ",subjid))
    	hist(subjdata$base[burnin:length(subjdata[,1])],xlab="Baseline",ylab="",main=paste("Subject",sep=" ",subjid))
    }
     else if(count == 3)
	{
        path <- paste(graphLocation , "/Graph3.png",sep ='')
    	png(path,width = 810, height = 550)
    	par(mfrow=c(2,2))   
    
        ts.plot(subjdata$hl[burnin:length(subjdata[,1])],xlab="Iteration",ylab="Halflife ",main=paste("Subject",sep=" ",subjid))
    	hist(subjdata$hl[burnin:length(subjdata[,1])],xlab="Halflife",ylab="",main=paste("Subject",sep=" ",subjid))
    }
    else if(count == 4)
    {
    
        path <- paste(graphLocation , "/Graph4.png",sep ='')
    	png(path,width = 810, height = 550)

        rawdata<-read.table(DataFile,fill=T)
    
        psubjdata <- read.table(ParmFile,col.names= c("iter","npulse","pulsenumb","pmass","pwidth","location"),fill=T)  #subject's pulse specific parameters
	    psubjdata <- subset(psubjdata,psubjdata$iter>=burnin)
        
        common <- read.table(commonFile,col.names= c("iter","mpmass","mpwidth","popsigmaa","popsigmaw","sigmaa","sigmaw","base",  "hl", "popsigmab","popsigmahl", "evar"),fill=T)
	    common <- subset(common,common$iter>=burnin)

    ###call fitted data function to created fitted values###
        fitted.m<-postpredcalc(burnin,rawdata,subjdata,psubjdata,common,subjid,"test.txt")
    
        ploc<-subset(psubjdata,pdata$location>=min(rawdata[,1]))
        ploc<-subset(ploc,ploc$location<=max(rawdata[,1]))
    
   
        nf<-layout(matrix(c(1,2),2,1,byrow=F),c(1.5,1.5),c(1.0,0.4),TRUE)   ###This is needed to make one graph with two parts####
    
        par(mar=c(0,4,2,0))
        plot(rawdata[,1],rawdata[,(subjid+1)],
               ylab="Hormone Concentration",
               ylim=c(min(rawdata[,(subjid+1)],fitted.m[,3]),max(rawdata[,(subjid+1)],fitted.m[,4])),
               xlim=c(min(rawdata[,1]),max(rawdata[,1])),
               type="o",
               pch=20,
               col="grey55",
               axes="F",
               main=paste("Posterior Predictive Fits for Subject ",subjid,sep=""))
        axis(2)
        box(lwd=2)
        lines(rawdata[,1],fitted.m[,1],lwd=2,col=2)
        lines(rawdata[,1],fitted.m[,3],lwd=1,col=1,lty=2)
        lines(rawdata[,1],fitted.m[,4],lwd=1,col=1,lty=2)
    
        par(mar=c(4,4,0,0))
        hist(ploc[,6],breaks=seq(min(rawdata[,1]),max(rawdata[,1]),),col=3,ylab="",xlab="Time (in min)",main="",axes=F)
        axis(1)
        box(lwd=2)
    }
	
}


args <- commandArgs(TRUE)
iterator <- as.integer(args[1])
burnin <- as.double(args[2])
DataFile <- args[3]
subjFile <- args[4]
ParmFile <- args[5]
commonFile <- args[6]
subjid <- as.integer(args[7])
graphLocation <- args[8]
subjgraphs(iterator,burnin,DataFile,subjFile,ParmFile,commonFile,subjid,graphLocation)
