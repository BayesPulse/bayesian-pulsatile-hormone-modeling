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



graph <- function(burnin,commonFile,parmFile,mconFile,dataFile,fileName){
	
	data <- read.table(commonFile,col.names= c("pulses","base","mpmass", "mpwidth", "hl", "C0","evar", "RE1","RE2","RE3"),fill=T)
	pdata<-read.table(parmFile,col.names=c("iter","npulses","pnumb","ploc","pmass","pwidth","eta"),fill=T)


	pdata<-pdata[pdata$iter>=burnin,]
    

        
    	pdf(file = fileName)
    
    	par(mfrow=c(2,2))
     
    	ts.plot(data$pulses[burnin:length(data[,1])],main="# of Pulses ")
    	hist(data$pulses[burnin:length(data[,1])],main="Histogram of # of Pulses")


    	mean<-mean(data$pulses[burnin:length(data[,1])])
    	var<-var(data$pulses[burnin:length(data[,1])])
    	quant<-quantile(data$pulses[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
	
    	ts.plot(data$base[burnin:length(data[,1])],main="Baseline ")
    	hist(data$base[burnin:length(data[,1])],main="Histogram of Baseline")

        

    	mean<-mean(data$base[burnin:length(data[,1])])
    	var<-var(data$base[burnin:length(data[,1])])
    	quant<-quantile(data$base[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$mpmass[burnin:length(data[,1])],main= "Mean Pulse Mass ")
    	hist(data$mpmass[burnin:length(data[,1])],main="Histogram of Mean Pulse Mass")


    	mean<-mean(data$mpmass[burnin:length(data[,1])])
    	var<-var(data$mpmass[burnin:length(data[,1])])
    	quant<-quantile(data$mpmass[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))
	
    	ts.plot(data$mpwidth[burnin:length(data[,1])],main="Mean Pulse Width ")   
    	hist(data$mpwidth[burnin:length(data[,1])],main="Histogram of Mean Pulse Width")


    	mean<-mean(data$mpwidth[burnin:length(data[,1])])
    	var<-var(data$mpwidth[burnin:length(data[,1])])
    	quant<-quantile(data$mpwidth[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$hl[burnin:length(data[,1])],main="Halflife ")
    	hist(data$hl[burnin:length(data[,1])],main="Histogram of Halflife")
	
    	mean<-mean(data$hl[burnin:length(data[,1])])
    	var<-var(data$hl[burnin:length(data[,1])])
    	quant<-quantile(data$hl[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	ts.plot(data$evar[burnin:length(data[,1])],main="Error Variance ")
    	hist(data$evar[burnin:length(data[,1])],main="Histogram of Error Variance")


    	mean<-mean(data$evar[burnin:length(data[,1])])
    	var<-var(data$evar[burnin:length(data[,1])])
    	quant<-quantile(data$evar[burnin:length(data[,1])],c(0.025,0.05,0.5,0.95,0.975))

    	hist(pdata$ploc,breaks=seq(-100,1600,by=5),main="Pulse Locations")
    
    
    
    
    ###Read in data and make basic plot of the data
    contdata1<-matrix(scan(dataFile,skip=1),ncol=3,byrow=T)
    #pdf("F:/Nichole/K12/software_info/SeniorDesignProject/Figures_code/FigureData.pdf")
    plot(contdata1[,2],contdata1[,3],xlab="Time (in min)",ylab="Hormone Concentration",col=1,lwd=1.5,type="l",cex=2.25)
    
    
    ####Output graph
    ###Read in the data#####
    contdata1<-matrix(scan(dataFile,skip=1),ncol=3,byrow=T)
    ploccont<-matrix(scan(parmFile),ncol=7,byrow=T)
    ploccont<-ploccont[ploccont[,4]>=min(contdata1[,2]),]
    ploccont<-ploccont[ploccont[,4]<=max(contdata1[,2]),]
    postpred1<-matrix(scan(mconFile),ncol=nrow(contdata1),byrow=T)
    #####NOTE THIS VALUE NEEDS TO COME FROM THEIR INPUTS IN THE PROGRAM  BURNIN/NN ######
    postpred1<-postpred1[burnin:nrow(postpred1),]
    meanpred1<-apply(postpred1,2,mean)
    quantpred1<-apply(postpred1,2,quantile,probs=c(0.05,0.95))
    
    #pdf("F:/Nichole/K12/software_info/SeniorDesignProject/Figures_code/FigureModelFit.pdf")
    # nf<-layout(matrix(c(1,2),2,1,byrow=F),c(1.5,1.5),c(1.0,0.4),TRUE)
    #layout.show(nf)
    # par(mfrow=c(2,2))
    
    plot(contdata1[,2],contdata1[,3],xlab="Time (in min)",ylab="Hormone Concentration",ylim=c(min(contdata1[,3],quantpred1[1,]),max(contdata1[,3],quantpred1[2,])),xlim=c(min(contdata1[,2]),max(contdata1[,2])),type="o",pch=20,col="grey55",axes="T")
    axis(2)
    
    lines(contdata1[,2],meanpred1,lwd=2,col=2)
    lines(contdata1[,2],quantpred1[1,],lwd=1,col=1,lty=2)
    lines(contdata1[,2],quantpred1[2,],lwd=1,col=1,lty=2)
    
    # hist(ploccont[,4],breaks=seq(min(contdata1[,2]),max(contdata1[,2]),by=5),col=3,xlab="",ylab="Time (in min)",main="")
}


args <- commandArgs(TRUE)
burnin <- as.double(args[1])
commonFile <- args[2]
parmFile <- args[3]
mconFile <- args[4]
dataFile <- args[5]
graphLocation <- args[6]
graph(burnin,commonFile,parmFile,mconFile,dataFile,graphLocation)
    