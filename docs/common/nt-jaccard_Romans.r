pdf(file='nt-jaccard-Romans-Rplots.pdf');
library(sm); data = NULL; group = NULL;
jaccard <- read.csv('nt-jaccard_Romans.csv', header = F);
sm.density(jaccard,xlim=c(0,1),ylim=c(0,3),col='blue',lty=1,xlab='',ylab='');
par(new=TRUE);
