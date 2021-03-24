pdf(file='jaccard-Matthew-Rplots.pdf');
library(sm); data = NULL; group = NULL;
manual_nt_length <- read.csv('jaccard_Matthew.csv', header = F);
sm.density(manual_nt_length,xlim=c(0,1),ylim=c(0,3),col='blue',lty=1,xlab='',ylab='');
par(new=TRUE);
