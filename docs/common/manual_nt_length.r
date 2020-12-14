library(sm); data = NULL; group = NULL;
manual_nt_length <- read.csv('manual_nt_length.csv', header = F);
sm.density(manual_nt_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
