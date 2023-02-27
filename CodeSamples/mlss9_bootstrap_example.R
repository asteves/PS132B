rm(list=ls())
library(ggplot2)


# Constructing population -------------------------------------------------

set.seed(12345)
N <- 1000000
X <- rnorm(N, 153, 30)

hist(X)
mean(X)


# Drawing a sample --------------------------------------------------------

set.seed(12345)
n <- 1000
x <- sample(X,n)
mean(x)


# Classical approach to confidence interval for sample mean ---------------

#Confidence interval computed "manually":
alpha <- 0.05 #0.05 for 95% confidence interval
standard.error <- sd(x)/sqrt(n) #the standard deviation of the sample mean
critical.value <- qt(1 - alpha/2, df = n - 1) #t distribution critical value
#95% CI:
mean(x) - critical.value*standard.error; mean(x) + critical.value*standard.error


#Using canned function:
t.test(x)$conf.int


# Bootstrap prep ----------------------------------------------------------

#number of bootstrap iterations:
B <- 10000

#function for statistic of interest:
statint <- mean

#Note: we can bootstrap any statistic, not just the mean,
#and this can be done for multivariate settings as well!

#Create (empty) object(s) that will store results
bootout <- rep(NA,B)


# Run the bootstrap -------------------------------------------------------

set.seed(123)

for (i in 1:B){
  
  x.b <- sample(x = x, size = n, replace = TRUE)
  bootout[i] <- statint(x.b)
  
}

#Bootstrap standard error
sd(bootout)

#Bootstrap 95% Confidence Interval:
quantile(bootout, probs = c(0.025,0.975))

#What if the sample function had set replace = FALSE?


# Comparing bootstrap distribution to true distribution -------------------

#Imagine theoretically if we did have unlimited resources and time
#and could have actually sampled over and over again from the Population.
#This would let us see what the true (theoretical) distribution of the
#statistic of interest looks like

theoryout <- rep(NA,B)

set.seed(123)
for (i in 1:B){
  
  #Note that now we are resampling from X (population), not x (sample)
  x.theory <- sample(x = X, size = n)
  theoryout[i] <- statint(x.theory)
  
}

sd(bootout)
sd(theoryout)

#Interval length:
quantile(bootout, probs = c(0.975)) - 
  quantile(bootout, probs = c(0.025))
quantile(theoryout, probs = c(0.975)) - 
  quantile(theoryout, probs = c(0.025))

pframe <- data.frame(sample.stat = c(bootout,theoryout),
                     method = c(rep("Bootstrap Resampling",B),
                                rep("Theoretical Population Resampling", B)))
ggplot(pframe, aes(x = sample.stat)) + geom_histogram() +
  facet_wrap(~ method, ncol = 1) + 
  xlab("Sample Statistic of Interest\n(Code File Default is Mean)")

library(dplyr)
pframe.add <- pframe %>% group_by(method) %>%
  summarise(low = quantile(sample.stat, probs = 0.025),
            high = quantile(sample.stat, probs = 0.975))

ggplot(pframe, aes(x = sample.stat)) + geom_histogram() +
  facet_wrap(~ method, ncol = 1) + 
  geom_vline(data = pframe.add, aes(xintercept = low)) + 
  geom_vline(data = pframe.add, aes(xintercept = high)) + 
  xlab("Sample Statistic of Interest\n(Code File Default is Mean)") +
  geom_vline(xintercept = mean(X), color = "red", linetype = 2)


# Alternative implementation ----------------------------------------------

#In programming in general, the same task can often be implemented
#using several different approaches.

#As an example, the following is an alternative implementation
#of the bootstrap that avoids the explicit use of a for-loop.

set.seed(123)

#Generate all random re-samples at once:
x.b.all <- replicate(B, expr = sample(x = x, size = n, replace = TRUE))
dim(x.b.all)

#Compute the summary statistic on all re-samples:
bootout.alt <- apply(x.b.all, MARGIN = 2, FUN = statint)
length(bootout.alt)

#95% Confidence Interval:
quantile(bootout.alt, probs = c(0.025,0.975))

#Compare that to the earlier CI:
quantile(bootout, probs = c(0.025,0.975))


# A more complicated example ----------------------------------------------

#Population with two variables
library(mvtnorm)
set.seed(12345)
N <- 1000000
matout <- rmvnorm(N, mean = c(50,75), sigma = matrix(c(1,0.1,0.1,1), nrow = 2))
X <- matout[,1]
W <- matout[,2]
cor(X,W)

#Sample
set.seed(12345)
n <- 1000
k <- sample(1:N, n)
x <- X[k]
w <- W[k]
cor(x,w)

#Bivariate statistic of interest
statint2 <- cor

#Bootstrapped confidence interval on the correlation
B <- 10000
bootout2 <- rep(NA,B)

set.seed(123)
for (i in 1:B){
  
  k.b <- sample(1:n, n, replace = TRUE)
  x.b <- x[k.b]
  w.b <- w[k.b]
  bootout2[i] <- statint2(x.b, w.b)
  
}

quantile(bootout2, probs = c(0.025,0.975))
