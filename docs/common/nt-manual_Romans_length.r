pdf(file='nt-Romans-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Romans_length <- read.csv('nt-manual_Romans_length.csv', header = F);
sm.density(manual_Romans_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
