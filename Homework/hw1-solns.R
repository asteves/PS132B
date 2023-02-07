### 
set.seed(8675309)

### Create a vector 
vec1 = 1:1000
avec1 = seq(1,1000,1)

### Sampling 
vec2 = sample(vec1, replace = F)
avec2 = sample(avec1)

### Creating a data frame 
dat = data.frame(vec1, vec2)

### compute correlation 
cor(dat$vec1, dat$vec2)

### 
hdat = read.csv("data_health_synth_small.csv")

dim(hdat)

## alternatively 
nrow(hdat)
ncol(hdat)

summary(hdat)

### Mean difference 
cost_b = mean(hdat$cost[hdat$race == "black"])
cost_w = mean(hdat$cost[hdat$race == "white"])

ate = cost_b - cost_w
ate
### Bootstrapping 
ncol(hdat)
nrow(hdat)

### make a function 
boot_it = function(data){
  idx = sample(nrow(data), replace = T)
  data = data[idx,]
  print(nrow(data))
  cost_b = mean(data[["cost"]][data[["race"]] == "black"], na.rm = T)
  cost_a = mean(data[["cost"]][data[["race"]] == "white"], na.rm = T)
  return(cost_b - cost_a)
}
N = 1000
b = vector(mode = "numeric", length = N)
for(i in 1:N){
  b[i] = boot_it(hdat)
}

lwr = ate -1.96*sd(b)
upp = ate + 1.96*sd(b)
