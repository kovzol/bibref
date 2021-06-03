pdf(file='nt-Matthew-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Matthew_length <- read.csv('nt-manual_Matthew_length.csv', header = F);
sm.density(manual_Matthew_length,xlim=c(0,350),ylim=c(0,0.02),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
