rm(list = ls())


# Introducing for loops ---------------------------------------------------

#Basic structure:
#Let i be an arbitrary index 
#and k be the number of loop iterations:

for (i in 1:k){
  
  #Do something
  
}

#Simple example 1: Print a sequence
k <- 20
for (i in 1:k){
  print(i)
}

#Simple example 2: Factorial sequence
for (i in 1:10){
  x <- seq(1:i)
  prodx <- prod(x)
  print(i)
  print(prodx)
  cat("\n")
}
#To closely inspect what is happening inside a loop,
#It can be useful to set i to some value,
#and then run the lines of code within the loop
#one by one.

#Nested loop example
tmat <- matrix(data = c(1,6,3,7,8,2), nrow = 2, ncol = 3)
tmat

for (i in 1:nrow(tmat)){
  for (j in 1:ncol(tmat)){
    print(tmat[i,j])
  }
}


# For loop applied example: Data analysis ---------------------------------

dat <- read.csv("asylum_survey_data.csv")
dat <- na.omit(dat)

head(dat)

ctys <- sort(unique(dat$cty))
ctys

#Print correlations between asylum preference and ideology
#for all 15 countries
for (i in 1:length(ctys)){
  
  this.cty <- ctys[i]
  this.dat <- subset(dat,dat$cty == this.cty)
  this.cor <- cor(this.dat$asylum_home,this.dat$ideo_scale)
  round.cor <- round(this.cor,digits = 3)
  print(paste(this.cty,":",round.cor))
  
}

#Store the correlations instead
corframe <- data.frame(cty = ctys,cor = NA)
for (i in 1:length(ctys)){
  
  this.cty <- ctys[i]
  this.dat <- subset(dat,dat$cty == this.cty)
  this.cor <- cor(this.dat$asylum_home,this.dat$ideo_scale)
  corframe$cor[i] <- this.cor
  
  rm(this.cty,this.dat,this.cor)
  
}
corframe


# For loop applied example: Simulation ------------------------------------

#An example of something a data scientist might do:

#Building blocks:
nsamp <- 100
x <- runif(n = nsamp, min = 5, max = 10)
y <- 5 + 2*x + rnorm(nsamp, mean = 0, sd = 4)
tdat <- data.frame(y,x)

#Looping it:
nsamp <- 100
iter <- 10000
dlist <- list()
set.seed(123)
for (i in 1:iter){
  
  x <- runif(n = nsamp, min = 5, max = 10)
  y <- 5 + 2*x + rnorm(nsamp, mean = 0, sd = 4)
  tdat <- data.frame(y,x)
  
  dlist[[i]] <- tdat
  rm(x,y,tdat)
  
}

#Analyzing one iteration:
tdat <- dlist[[1]]
tmod <- lm(y ~ x, tdat)
summary(tmod)
coef(tmod)["(Intercept)"]
coef(tmod)["x"]

#Analyzing the output of the entire loop:
beta0.vec <- rep(NA,iter)
beta1.vec <- rep(NA,iter)

for (i in 1:iter){
  
  tdat <- dlist[[i]]
  tmod <- lm(y ~ x, tdat)
  beta0.vec[i] <- coef(tmod)["(Intercept)"]
  beta1.vec[i] <- coef(tmod)["x"]
  rm(tdat,tmod)
  
}

mean(beta0.vec)
hist(beta0.vec)

mean(beta1.vec)
hist(beta1.vec)


# An aside on RNG seeds ---------------------------------------------------

#It is good practice to set the RNG seed whenever you are
#implementing anything with randomness
#so that you and others can exactly replicated your work.

#As an example:
rnorm(5)
rnorm(5)
rnorm(5)

set.seed(111)
rnorm(5)

set.seed(111)
rnorm(5)

set.seed(123)
rnorm(5)

set.seed(123)
rnorm(5)


#But be careful with where you are setting the seed,
#especially when used in conjunction with loops.
#For example...

#Good:
nsamp <- 5
iter <- 3
dlist <- list()
set.seed(123)  #seed set outside loop
for (i in 1:iter){
  
  x <- runif(n = nsamp, min = 5, max = 10)
  y <- 5 + 2*x + rnorm(nsamp, mean = 0, sd = 4)
  tdat <- data.frame(y,x)
  
  dlist[[i]] <- tdat
  rm(x,y,tdat)
  
}
dlist

#Bad:
nsamp <- 5
iter <- 3
dlist <- list()
for (i in 1:iter){
  
  set.seed(123)  #seed set inside loop
  x <- runif(n = nsamp, min = 5, max = 10)
  y <- 5 + 2*x + rnorm(nsamp, mean = 0, sd = 4)
  tdat <- data.frame(y,x)
  
  dlist[[i]] <- tdat
  rm(x,y,tdat)
  
}
dlist


# While loop: an alternative type of loop ---------------------------------

i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}


# Introducing functions ---------------------------------------------------

#We have many pre-programmed functions
#from base R and from packages
median(dat$ideo_scale)
min(dat$ideo_scale)
max(dat$ideo_scale)
quantile(dat$ideo_scale,probs = c(0.1,0.9))
summary(dat$ideo_scale)

#But we can also create our own custom functions
mysummary <- function(x){
  
  out <- c(min(x),
           quantile(x,probs = 0.1),
           median(x),
           quantile(x,probs = 0.9),
           max(x))
  names(out) <- c("Min",
                  "10th Perc",
                  "Median",
                  "90th Perc",
                  "Max")
  return(out)
  
}

mysummary(x = dat$ideo_scale)
mysummary(x = dat$age)
mysummary(x = dat$eisced)


#Common errors: function execution

mysummary()
mysummary(x = dat)
mysummary(x = dat$emp_status)


#Common errors: function writing

mysummary.error1 <- function(x){
  
  out <- c(min(x),
           quantile(x,probs = 0.1),
           median(x),
           quantile(x,probs = 0.9),
           max(x))
  names(out) <- c("Min",
                  "10th Perc",
                  "Median",
                  "90th Perc",
                  "Max")
  
}

mysummary.error1(x = dat$ideo_scale)


mysummary.error2 <- function(x){
  
  out <- (min(x),
          quantile(x,probs = 0.1),
          median(x),
          quantile(x,probs = 0.9),
          max(x))
  names(out) <- ("Min",
                 "10th Perc",
                 "Median",
                 "90th Perc",
                 "Max")
  return(out)
  
}

mysummary.error2(x = dat$ideo_scale)


mysummary.error3 <- function(x){
  
  out <- c(min(dat$ideo_scale),
           quantile(dat$ideo_scale,probs = 0.1),
           median(dat$ideo_scale),
           quantile(dat$ideo_scale,probs = 0.9),
           max(dat$ideo_scale))
  names(out) <- c("Min",
                  "10th Perc",
                  "Median",
                  "90th Perc",
                  "Max")
  return(out)
  
}

mysummary.error3(x = dat$ideo_scale)
mysummary.error3(x = dat$age)


# Applied function example ------------------------------------------------

regsim <- function(iter,xfix,beta0,beta1,errorsd){
  
  x <- xfix
  nsamp <- length(xfix)
  beta1.vec <- rep()
  
  for (i in 1:iter){
    y <- beta0 + beta1*x + 
      rnorm(n = nsamp, mean = 0, sd = errorsd)
    tmod <- lm(y ~ x)
    beta1.vec[i] <- coef(tmod)["x"]
    rm(y,tmod)
  }
  
  return(beta1.vec)
  
}

use.this.x <- runif(n = 100, min = 0, max = 10)

test1 <- regsim(iter = 1000, xfix = use.this.x, 
                beta0 = 1, beta1 = 5, errorsd = 10)
test2 <- regsim(iter = 1000, xfix = use.this.x, 
                beta0 = 100, beta1 = 5, errorsd = 10)
test3 <- regsim(iter = 1000, xfix = use.this.x, 
                beta0 = 1, beta1 = 5, errorsd = 20)
test4 <- regsim(iter = 1000, xfix = use.this.x, 
                beta0 = 1, beta1 = 5, errorsd = 50)

par(mfrow=c(2,2)) 
hist(test1, xlim = c(-2,12))
hist(test2, xlim = c(-2,12))
hist(test3, xlim = c(-2,12))
hist(test4, xlim = c(-2,12))
dev.off()
