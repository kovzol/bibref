pdf(file='jaccard-Psalms-Rplots.pdf');
library(sm); data = NULL; group = NULL;
manual_nt_length <- read.csv('jaccard_Psalms.csv', header = F);
sm.density(manual_nt_length,xlim=c(0,1),ylim=c(0,5),col='blue',lty=1,xlab='',ylab='');
par(new=TRUE);
