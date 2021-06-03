pdf(file='ot-Psalms-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Psalms_length <- read.csv('ot-manual_Psalms_length.csv', header = F);
sm.density(manual_Psalms_length,xlim=c(0,350),ylim=c(0,0.016),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
