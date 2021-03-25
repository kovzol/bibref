pdf(file='jaccard-Hebrews-Rplots.pdf');
library(sm); data = NULL; group = NULL;
jaccard <- read.csv('jaccard_Hebrews.csv', header = F);
sm.density(jaccard,xlim=c(0,1),ylim=c(0,3),col='blue',lty=1,xlab='',ylab='');
par(new=TRUE);
