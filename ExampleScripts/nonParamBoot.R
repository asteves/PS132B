vec = c(rep(1, .22*1000), 
        rep(0, 1000-.22*1000)
        )

estimate = mean(vec)

N = 100000
boots = vector(mode = "logical", length = N)
for(i in 1:N){
  boots[i] = mean(sample(vec, 1000, replace = T))
}

bootMean = mean(boots)
bootSD = sd(boots)

## Approximate the Bootstrap confidence interval 
bootMean - 2*bootSD
bootMean + 2*bootSD

## Another way to do this 
way2 = replicate(100000, mean(sample(vec, 1000, replace = T)))
bootMean2 = mean(way2)
bootSD2 = sd(boots)

## Approximate the boostrap confidence interval 
bootMean2 - 2*bootSD2
bootMean2 - 2*bootSD2

## Which way is faster? 
## One way to think about this is to put these routines into 
## functions for clarity 
useForLoop = function(N = 100000, prealloc = TRUE){
  set.seed(1)
  vec = c(rep(1, .22*1000), 
          rep(0, 1000-.22*1000)
  )
  ##
  if(prealloc){
    boots = vector(mode = "logical", length = N)
    for(i in 1:N){
      boots[i] = mean(sample(vec, 1000, replace = T))
    }
  } else {
    boots = NULL
    for(i in 1:N){
      boots[i] = mean(sample(vec, 1000, replace = T))
    }
  }

  boots
}

useReplicate = function(N = 100000){
  set.seed(1)
  vec = c(rep(1, .22*1000), 
          rep(0, 1000-.22*1000)
  )
  
  way2 = replicate(N, mean(sample(vec, 1000, replace = T)))
  way2
}

system.time(useForLoop(N=1000000))
system.time(useReplicate(N=1000000))

## On my machine they take basically the same amount of time 

## what if we don't pre-allocate memory for the for loop?
system.time(useForLoop(N=1000000,prealloc=FALSE))

## When I do it on my machine 
## The for loop preallocated is the quickest. The for loop without preallocation is the slowest
# > system.time(useForLoop(N=1000000))
# user  system elapsed 
# 54.607   1.539  57.464 
# > system.time(useReplicate(N=1000000))
# user  system elapsed 
# 59.062   1.516  61.727 
# > ## what if we don't pre-allocate memory for the for loop?
#   > system.time(useForLoop(N=1000000,prealloc=FALSE))
# user  system elapsed 
# 57.014   1.979  64.539 