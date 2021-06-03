pdf(file='ot-Isaiah-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Isaiah_length <- read.csv('ot-manual_Isaiah_length.csv', header = F);
sm.density(manual_Isaiah_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
