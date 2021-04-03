pdf(file='Acts-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Acts_length <- read.csv('manual_Acts_length.csv', header = F);
sm.density(manual_Acts_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
