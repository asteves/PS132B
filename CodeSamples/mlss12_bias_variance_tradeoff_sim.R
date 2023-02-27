rm(list = ls())
library(ggplot2)
set.seed(123)

# Functions ---------------------------------------------------------------

x.gen <- function(n){
  x <- runif(n, min = -0.5, max = 1.5)
  return(x)
}

mean.func <- function(x){
  Ey <- 2 + 3*x - 10*x^2 + 3*x^3 + 5*x^4
  return(Ey)
}

dgp <- function(x){
  y <- 2 + 3*x - 10*x^2 + 3*x^3 + 5*x^4 + rnorm(length(x),sd=1.5)
  return(y)
}

n <- 100
fullx <- seq(from = -0.5, to = 1.5, by = 0.001)


# Step 1: Show true mean line ---------------------------------------------

x.new <- fullx
y.new <- mean.func(x.new)
newdat <- data.frame(x = x.new, y = y.new)
mfplot <- ggplot() + geom_line(data = newdat, aes(x=x,y=y), color = "red") + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0))
mfplot


# Step 2: Show DGP around mean line ---------------------------------------

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
mfplot + geom_point(data = newdat, aes(x=x,y=y))


# Step 3: Show just DGP ---------------------------------------------------

just.dgp <- ggplot() + geom_point(data = newdat, aes(x=x,y=y)) + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0))
just.dgp


# Step 4: Fits on many hypothetical draws ---------------------------------

#First, trying degree-3 polynomial
pdeg <- 3

just.dgp + geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
ggplot() + geom_point(data = newdat, aes(x=x,y=y)) + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
ggplot() + geom_point(data = newdat, aes(x=x,y=y)) + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
ggplot() + geom_point(data = newdat, aes(x=x,y=y)) + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
ggplot() + geom_point(data = newdat, aes(x=x,y=y)) + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)


# Now just the lines ------------------------------------------------------

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- ggplot() + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- just.lines +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- just.lines +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- just.lines +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

for (i in 1:20){
  x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
  just.lines <- just.lines +
    geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
}
just.lines


# If were to do that infinite times, the average would be -----------------

x.new <- fullx; y.new <- mean.func(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- just.lines +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "dodgerblue", linewidth=1.5, method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines


# And compare it to true mean func, discuss bias vs. variance -------------

just.lines <- just.lines +
  geom_line(data = newdat, aes(x=x,y=y), color = "red", size = 1.5)
just.lines


# And now for higher degree (degree 8) ------------------------------------

dev.off()
set.seed(2468)

pdeg <- 8
x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- ggplot() + theme_bw() +
  coord_cartesian(xlim = c(-0.5,1.5), ylim = c(-5,11)) +
  scale_x_continuous(limits=c(-0.5,1.5), expand = c(0, 0)) +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

for (i in 1:20){
  x.new <- x.gen(n); y.new <- dgp(x.new); newdat <- data.frame(x = x.new, y = y.new)
  just.lines <- just.lines +
    geom_smooth(data = newdat, aes(x=x,y=y), color = "black", method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
}
just.lines

#The fitted function in expectation
x.new <- fullx; y.new <- mean.func(x.new); newdat <- data.frame(x = x.new, y = y.new)
just.lines <- just.lines +
  geom_smooth(data = newdat, aes(x=x,y=y), color = "dodgerblue", size=1.5, method = "lm", formula = y ~ poly(x,pdeg), se = F, fullrange=TRUE)
just.lines

#Compared to the truth
just.lines <- just.lines +
  geom_line(data = newdat, aes(x=x,y=y), color = "red", size = 1)
just.lines


# Compute bias and variance across all degrees ----------------------------

set.seed(123)
sims <- 5000
degrees <- seq(from = 3, to = 8)
out.var <- rep(NA, length(degrees))
out.bias2 <- rep(NA, length(degrees))

for (k in 1:length(degrees)){
  
  this.degree <- degrees[k]
  
  simmat <- matrix(NA, nrow = length(fullx), ncol = sims)
  
  for (j in 1:sims){
    x.new <- x.gen(n); y.new <- dgp(x.new)
    newdat <- cbind(y = y.new,as.data.frame(poly(x.new,this.degree,raw = T)))
    mod <- lm(y ~ ., newdat)
    simmat[,j] <- predict(mod, newdata = as.data.frame(poly(fullx,this.degree,raw = T)))
  }
  
  out.var[k] <- mean(apply(simmat, MARGIN = 1, var))
  out.bias2[k] <- mean((mean.func(fullx) - apply(simmat, MARGIN = 1, mean))^2)
  print(k)
  
}

bvtradeoff <- data.frame(degrees = degrees, var = out.var, 
                         bias2 = out.bias2, mse = out.var + out.bias2)
save(bvtradeoff,file = "bvtradeoff.Rdata")


# Results -----------------------------------------------------------------

load(file = "bvtradeoff.Rdata")
degrees <- sort(unique(bvtradeoff$degrees))
bvt.pdat <- data.frame(Degree = rep(degrees,3),
                       Value = c(bvtradeoff$var,bvtradeoff$bias2,bvtradeoff$var + bvtradeoff$bias2),
                       Metric = factor(rep(c("Variance","Bias Squared","Mean Squared Error"),each = length(degrees)),
                                       levels = c("Bias Squared","Variance","Mean Squared Error")))

ggplot(bvt.pdat) + geom_line(aes(x = Degree, y = Value, color = Metric)) +
  geom_point(aes(x = Degree, y = Value, color = Metric)) +
  theme_bw() +
  facet_grid(Metric~.) +
  theme(legend.position = "none") +
  theme(strip.text = element_text(size = 18)) +
  xlab("Polynomial Degree") +
  theme(axis.title = element_text(size = 14)) +
  theme(axis.text = element_text(size = 14))
