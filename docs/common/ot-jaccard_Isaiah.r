pdf(file='ot-jaccard-Isaiah-Rplots.pdf');
library(sm); data = NULL; group = NULL;
jaccard <- read.csv('ot-jaccard_Isaiah.csv', header = F);
sm.density(jaccard,xlim=c(0,1),ylim=c(0,5),col='blue',lty=1,xlab='',ylab='');
par(new=TRUE);
