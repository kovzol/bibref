pdf(file='nt-Hebrews-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Hebrews_length <- read.csv('nt-manual_Hebrews_length.csv', header = F);
sm.density(manual_Hebrews_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
