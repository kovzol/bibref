pdf(file='multi-Rplots.pdf')
library(sm); data = NULL; group = NULL;
manual_Matthew_length <- read.csv('nt-manual_Matthew_length.csv', header = F);
sm.density(manual_Matthew_length,xlim=c(0,350),ylim=c(0,0.02),col='red',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
manual_Romans_length <- read.csv('nt-manual_Romans_length.csv', header = F);
sm.density(manual_Romans_length,xlim=c(0,350),ylim=c(0,0.02),col='blue',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
manual_Hebrews_length <- read.csv('nt-manual_Hebrews_length.csv', header = F);
sm.density(manual_Hebrews_length,xlim=c(0,350),ylim=c(0,0.02),col='green',lty=1,positive=TRUE,xlab='',ylab='');
par(new=TRUE);
legend('top','groups',c('Matthew','Romans','Hebrews'),lty=c(1,1,1),col=c('red','blue','green'),ncol=3,bty="n");
